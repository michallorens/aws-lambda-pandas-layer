#!/usr/bin/env bash
DIR="$(dirname "${BASH_SOURCE[0]}")/build/libs/python/lib/python$1/site-packages"
shift
pip install --quiet --disable-pip-version-check "$@" --target "$DIR"
jq -n "{ path: \"$DIR\" }"