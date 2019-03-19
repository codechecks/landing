#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
cd ..

[ -z "$AWS_CLOUD_FRONT_DISTRIBUTION_ID" ] && echo "Need to set \$AWS_CLOUD_FRONT_DISTRIBUTION_ID" && exit 1;

echo "Uploading new files to s3"
aws s3 sync static s3://codechecks-landing-bucket

echo "Invalidating Cloudfront cache"
aws cloudfront create-invalidation --distribution-id $AWS_CLOUD_FRONT_DISTRIBUTION_ID --paths "/*"

echo "done."