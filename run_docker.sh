#!/bin/bash
rm -rf "$(dirname "${BASH_SOURCE[0]}")"/build
mkdir "$(dirname "${BASH_SOURCE[0]}")"/build
docker run --name build-lambda-layer "$@" > /dev/null 2>&1
docker cp build-lambda-layer:/libraries.zip "$(dirname "${BASH_SOURCE[0]}")"/build/libraries.zip > /dev/null 2>&1
docker rm build-lambda-layer > /dev/null 2>&1
jq -n "{ path: \"$(dirname "${BASH_SOURCE[0]}")/build/libraries.zip\" }"