#!/bin/bash

base_dir="$(dirname $(realpath $0))"

# change directory to base directory
cd "$base_dir"

rm -rf build/web
flutter pub get
flutter build web --release

dist_bucket="starrynight-web"

# Sync
aws s3 sync build/web/ s3://${dist_bucket} --delete

exit

# TODO: distribution id
# Invalidate cloudfront to flush the edge node caches
DISTRIBUTION_ID=`aws cloudfront list-distributions |
  jq -r '.DistributionList.Items[] | select(.Comment == "myapp-prod distribution") | .Id'`
aws cloudfront create-invalidation --distribution-id ${DISTRIBUTION_ID} --paths '/*'
