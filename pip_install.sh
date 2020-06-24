#!/bin/bash
DIR="/pip/libs/python/lib/python$PYTHON_VERSION/site-packages"
source scl_source enable rh-python"$PYTHON_VERSION"
pip3 install "$@" --target "$DIR" > /dev/null 2>&1