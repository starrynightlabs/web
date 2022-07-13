provider "aws" {
    region = "ap-southeast-1"
}
module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"
  version = "2.9.3"

  aliases = ["starrynight.world"]
  # manual job: should add an A record in route53

  comment             = "starrynight web by flutter"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = true
  wait_for_deployment = true
  default_root_object = "index.html"

  create_origin_access_identity = true
  origin_access_identities = {
    flutter_web_s3_bucket = "Access for starrynight-web"
  }

  origin = {
    flutter_web_s3 = {
      domain_name = "starrynight-web.s3.ap-southeast-1.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "flutter_web_s3_bucket"

        # manual job: should switch from No to "Yes, update the bucket policy" in cloud front origin settings
      }
    }
  }

  default_cache_behavior = {
    target_origin_id           = "flutter_web_s3"
    viewer_protocol_policy     = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  viewer_certificate = {
    acm_certificate_arn = var.acm_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
