#!/bin/bash
DIR="$(dirname "${BASH_SOURCE[0]}")"/build
CONTAINER_ID=build-lambda-layer-$(xxd -l 16 -p /dev/urandom | tr -d " \n")
rm -rf "$DIR"
mkdir "$DIR"
docker run --name "$CONTAINER_ID" "$@" > /dev/null 2>&1
docker cp "$CONTAINER_ID":/libraries.zip "$DIR"/libraries.zip > /dev/null 2>&1
docker rm "$CONTAINER_ID" > /dev/null 2>&1
jq -n "{ path: \"$DIR/libraries.zip\" }"