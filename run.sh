#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

if [[ ! -x  "$(command -v youtube-dl)" ]]
then
  echo "A dependency is missing: youtube-dl"
  exit 1
fi;

if [[ ! -x  "$(command -v aws)" ]]
then
  echo "A dependency is missing: awscli"
  exit 1
fi;

s3_bucket=${LUTH_S3_BUCKET:-}
if [[ -z ${s3_bucket} ]];
then
  echo "An environnement variable is missing: LUTH_S3_BUCKET"
  exit 1
fi;

[ ! -d "./out" ] && mkdir ./out

echo "Downloading sources audio files asynchronously..."
echo "Check log file to see current status: tail -f logs.txt"

while read -r src ; do
  (cd ./out && \
  IFS=';' read -ra src <<< "$src" && \
  echo "Downloading ${src[0]} from YouTube..." && \
  youtube-dl -x --audio-format wav -o "${src[0]}.wav" "${src[1]}" && \
  echo "${src[0]} was downloaded inside the out/ folder" && \
  echo "Uploading ${src[0]} to S3 bucket ${s3_bucket}..." && \
  aws s3 mv "${src[0]}.wav" "s3://${s3_bucket}" && \
  echo "${src[0]} was uploaded to S3 bucket ${s3_bucket}") >> logs.txt 2>&1 &
done < ./sources
