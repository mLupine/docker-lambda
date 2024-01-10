#!/usr/bin/env bash

set -euxo pipefail

docker build --platform linux/amd64 --no-cache --squash -t mlupin/lambda-base-2023:build .
