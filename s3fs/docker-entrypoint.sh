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
  /usr/bin/s3fs  ${S3_BUCKET} ${MNT_POINT} -d -f -o url=${S3_URL},retries=5,allow_other,umask=0,enable_noobj_cache,sigv2,del_cache,multipart_size=64,max_write=131072,big_writes,kernel_cache,max_background=1000,max_stat_cache_size=100000,parallel_count=30,multireq_max=30
else
  echo 'IAM_ROLE is set - using it to mount S3'
  /usr/bin/s3fs ${S3_BUCKET} ${MNT_POINT} -d -f -o url=${S3_URL},iam_role=${IAM_ROLE},retries=5,allow_other,umask=0,enable_noobj_cache,sigv2,del_cache,multipart_size=64,max_write=131072,big_writes,kernel_cache,max_background=1000,max_stat_cache_size=100000,parallel_count=30,multireq_max=30
fi