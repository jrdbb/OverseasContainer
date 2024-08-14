#!/bin/bash
set -euo pipefail
set -o errexit
set -o errtrace
IFS=$'\n\t'

mkdir -p ${MNT_POINT}

export AWS_ACCESS_KEY_ID =${AWS_ACCESS_KEY_ID :-$AWS_KEY}
export AWS_SECRET_ACCESS_KEY =${AWS_SECRET_ACCESS_KEY :-$AWS_SECRET_KEY}

/usr/bin/goofys ${S3_BUCKET} ${MNT_POINT} --endpoint ${S3_URL} --subdomain
