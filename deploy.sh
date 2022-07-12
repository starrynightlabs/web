#!/bin/bash

# TODO: check working directory
rm -rf build/web
flutter pub get
flutter build web --release --web-renderer canvaskit

# TODO: bucket name
dist_bucket=<your-bucket-name>

# Clean out the bucket
aws s3 rm s3://${dist_bucket} --recursive
# Upload everything fresh
aws s3 cp build/web/ s3://${dist_bucket} --recursive

# TODO: distribution id
# Invalidate cloudfront to flush the edge node caches
DISTRIBUTION_ID=`aws cloudfront list-distributions |
  jq -r '.DistributionList.Items[] | select(.Comment == "myapp-prod distribution") | .Id'`
aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths '/*'
