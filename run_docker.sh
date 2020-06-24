#!/bin/bash
rm -rf build/pip
docker run --name build-lambda-layer "$@" > /dev/null 2>&1
docker cp build-lambda-layer:/pip build > /dev/null 2>&1
docker rm build-lambda-layer > /dev/null 2>&1
jq -n '{ path: "build/pip" }'