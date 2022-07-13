#!/bin/bash

base_dir="$(dirname $(realpath $0))"

# change directory to base directory
cd "$base_dir"

flutter clean
flutter build web --release --web-renderer canvaskit

echo "dist_id: $WEB_CLOUDFRONT_DIST_ID"
echo "aws key: $AWS_ACCESS_KEY_ID"
echo "aws secret key: $AWS_ACCESS_KEY_ID"
aws --version
aws s3 ls

# check if logged in
if aws sts get-caller-identity && [[ $WEB_CLOUDFRONT_DIST_ID != "" ]]
then
  # sync
  aws s3 sync build/web/ s3://starrynight-web --delete

  # starrynight web by flutter
  aws cloudfront create-invalidation --distribution-id "$WEB_CLOUDFRONT_DIST_ID" --paths '/*'
else
  echo "-----------------------------------------------------------"
  echo "Failed to upload build output to s3, invalidate cloudfront"
  echo "Please log in AWS via 'aws configure',"
  echo "    set WEB_CLOUDFRONT_DIST_ID environment variable"
  echo "    and then rerun!"
  echo "-----------------------------------------------------------"
  exit 1
fi
