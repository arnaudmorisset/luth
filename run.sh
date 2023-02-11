#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

[ ! -d "./out" ] && mkdir ./out

while read -r src ; do
  (cd ./out && \
  IFS=';' read -ra src <<< "$src" && \
  echo "Downloading ${src[0]} from YouTube..." && \
  youtube-dl -x --audio-format wav -o "${src[0]}.wav" "${src[1]}" && \
  echo "${src[0]} was downloaded inside the out/ folder")
  # echo "Uploading ${src[0]} to S3 bucket ${LUTH_S3_BUCKET}..." && \
  # aws s3 mv "${src[0]}.wav" "s3://${LUTH_S3_BUCKET}" && \
  # echo "${src[0]} was uploaded to S3 bucket ${LUTH_S3_BUCKET}")
done < ./sources
