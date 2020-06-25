#!/bin/bash
DIR="$(dirname "${BASH_SOURCE[0]}")"/build
rm -rf "$DIR"
mkdir "$DIR"
docker run --name build-lambda-layer "$@" > /dev/null 2>&1
docker cp build-lambda-layer:/libraries.zip "$DIR"/libraries.zip > /dev/null 2>&1
docker rm build-lambda-layer > /dev/null 2>&1
jq -n "{ path: \"$DIR/libraries.zip\" }"