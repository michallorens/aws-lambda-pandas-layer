#!/bin/bash
DIR="python/lib/python$PYTHON_VERSION/site-packages"
pip3 install "$@" --target "$DIR"
find "$DIR" -name "*.so" | xargs strip -s
find "$DIR" -wholename "**/*.py[c|o]" | xargs rm -rf
find "$DIR" -wholename "**/__pycache__*" | xargs rm -rf
find "$DIR" -wholename "**/*.dist-info*" | xargs rm -rf
find "$DIR" -type d -name "boto3" | xargs rm -rf
find "$DIR" -type d -name "botocore" | xargs rm -rf
find "$DIR" -type d -name "dateutil" | xargs rm -rf
find "$DIR" -type d -name "distutils" | xargs rm -rf
find "$DIR" -type d -name "docutils" | xargs rm -rf
find "$DIR" -type d -name "pkg_resources" | xargs rm -rf
find "$DIR" -type d -name "setuptools" | xargs rm -rf
zip -r /libraries.zip python