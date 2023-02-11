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
  youtube-dl -x --audio-format wav "${src[1]}")
done < ./sources
