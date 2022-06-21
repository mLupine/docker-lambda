#!/bin/bash

set -euxo pipefail

docker build --progress plain --squash -t mlupin/docker-lambda:nodejs16.x-build-arm64 .
