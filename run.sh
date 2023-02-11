#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

readarray -t sources <<< "$(cat ./sources)"

[ ! -d "./out" ] && mkdir ./out

for source in "${sources[@]}"
do
  (cd ./out && \
  IFS=';' read -ra src <<< "$source" && \
  echo "Downloading ${src[0]} from YouTube..." && \
  youtube-dl -x --audio-format wav "${src[1]}")
done
