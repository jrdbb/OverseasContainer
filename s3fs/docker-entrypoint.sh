#!/bin/bash
set -euo pipefail
set -o errexit
set -o errtrace
IFS=$'\n\t'

export S3_ACL=${S3_ACL:-private}

mkdir -p ${MNT_POINT}

if [ "$IAM_ROLE" == "none" ]; then
  export AWSACCESSKEYID=${AWSACCESSKEYID:-$AWS_KEY}
  export AWSSECRETACCESSKEY=${AWSSECRETACCESSKEY:-$AWS_SECRET_KEY}

  echo "${AWS_KEY}:${AWS_SECRET_KEY}" > /etc/passwd-s3fs
  chmod 0400 /etc/passwd-s3fs

  echo 'IAM_ROLE is not set - mounting S3 with credentials from ENV'
  /usr/bin/s3fs  ${S3_BUCKET} ${MNT_POINT} -d -f -o url=${S3_URL},allow_other,retries=5,use_cache=/var/cache/s3fs
  echo 'started...'
else
  echo 'IAM_ROLE is set - using it to mount S3'
  /usr/bin/s3fs ${S3_BUCKET} ${MNT_POINT} -d -f -o url=${S3_URL},iam_role=${IAM_ROLE},allow_other,retries=5,use_cache=/var/cache/s3fs
fi