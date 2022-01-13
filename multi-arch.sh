#!/bin/sh

set -eu

if [ $# -ne 1 ]
then
  echo "$0 <version>" >&2
  exit 1
fi
VERSION=$1

IMAGE="rafaelostertag/astro-cli"
IMAGE_VERSIONED="${IMAGE}:${VERSION}"
IMAGE_LATEST="${IMAGE}:latest"

set -x
docker manifest create "${IMAGE_VERSIONED}" \
 --amend "${IMAGE}:${VERSION}-amd64" \
 --amend "${IMAGE}:${VERSION}-arm64"

docker manifest push "${IMAGE_VERSIONED}"

docker manifest create "${IMAGE_LATEST}" \
 --amend "${IMAGE}:${VERSION}-amd64" \
 --amend "${IMAGE}:${VERSION}-arm64"

docker manifest push "${IMAGE_LATEST}"
