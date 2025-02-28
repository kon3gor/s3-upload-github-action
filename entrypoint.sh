#!/bin/sh 

set -e

mkdir -p ~/.aws

touch ~/.aws/credentials

echo "[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" > ~/.aws/credentials

if [[ -z "$ENDPOINT" ]]; then
	aws s3 cp ${FILE} s3://${S3_BUCKET}/${S3_KEY} \
	  --region ${AWS_REGION} $*
else
	aws --endpoint-url=${ENDPOINT} s3 cp ${FILE} s3://${S3_BUCKET}/${S3_KEY} \
		--region ${AWS_REGION} $*
fi

rm -rf ~/.aws

