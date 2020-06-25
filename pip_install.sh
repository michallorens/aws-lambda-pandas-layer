#!/bin/bash
DIR="python/lib/python$PYTHON_VERSION/site-packages"
pip3 install "$@" --target "$DIR"
zip -r /libraries.zip python