#!/bin/sh

set -eu

if [ $# -ne 1 ]
then
  echo "$0 <version>" >&2
  exit 1
fi
VERSION=$1

docker manifest create "rafaelostertag/astro-cli:${VERSION}" \
 --amend "rafaelostertag/astro-cli:${VERSION}-amd64" \
 --amend "rafaelostertag/astro-cli:${VERSION}-arm64"

docker manifest push "rafaelostertag/astro-cli:${VERSION}"
