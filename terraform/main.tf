provider "aws" {
  # singapore
  region = "ap-southeast-1"
}

locals {
  name_with_env = "web_test"
}

resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "root_alias" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = module.cloudfront.cloudfront_distribution_domain_name
    zone_id                = module.cloudfront.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_cname" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = 300
  records = [module.cloudfront.cloudfront_distribution_domain_name]
}

resource "aws_route53_record" "acm_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.primary.zone_id
}

# AWS Certificate for app domain
resource "aws_acm_certificate" "cert" {
  # provider                  = aws.us_east_1
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  # provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_cert_validation_record : record.fqdn]
}

# Log bucket
resource "aws_s3_bucket" "cloudfront_log_bucket" {
  bucket_prefix = "${local.name_with_env}-cf-logs-"
}

resource "aws_s3_bucket_acl" "cloudfront_log_bucket_acl" {
  bucket = aws_s3_bucket.cloudfront_log_bucket.id
  acl = "log-delivery-write"
}

# Web app bucket
module "web_app" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 2.0"

  bucket_prefix = "${local.name_with_env}-web-app-"
  force_destroy = true
}

# Origin Access Identities
data "aws_iam_policy_document" "s3_web_app_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.web_app.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront.cloudfront_origin_access_identity_iam_arns
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.web_app.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_web_app_policy.json
}

# Request policy
resource "aws_cloudfront_origin_request_policy" "api_request_policy" {
  name = "${local.name_with_env}-api-request-policy"
  cookies_config {
    cookie_behavior = "all"
  }
  headers_config {
    header_behavior = "allViewer"
  }
  query_strings_config {
    query_string_behavior = "all"
  }
}

resource "aws_cloudfront_cache_policy" "api_cache_policy" {
  name        = "${local.name_with_env}-api-cache-policy"
  default_ttl = 0
  max_ttl     = 0
  min_ttl     = 0
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.2"

  comment             = "${local.name_with_env} distribution"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = true

  # These aliases can ONLY be on one CF distribution globally across all accounts.
  aliases = [
    var.domain_name,
    "www.${var.domain_name}",
  ]

  create_origin_access_identity = true
  origin_access_identities      = {
    web_app = "Starry night web app"
  }

  logging_config = {
    bucket = aws_s3_bucket.cloudfront_log_bucket.bucket_domain_name
    prefix = var.domain_name
  }

  origin = {
    default = {
      domain_name      = module.web_app.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "web_app" # key in `origin_access_identities`
      }
    }
  }

  # Everything that doesn't match an ordered_cache_behavior goes here (i.e., your SPA requests).
  default_cache_behavior = {
    target_origin_id       = "default"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true

    function_association = {
      viewer-request = {
        function_arn = aws_cloudfront_function.web_app_url_rewriter_cf_function.arn
      }
    }
  }

  viewer_certificate = {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }
}

# Cloudfront function to rewrite '/' -> '/index.html'
resource "aws_cloudfront_function" "web_app_url_rewriter_cf_function" {
  name    = "${local.name_with_env}-web-app-url-rewriter"
  runtime = "cloudfront-js-1.0"
  code    = file("url_rewriter.js")
}
