#!/bin/bash

set -euxo pipefail

docker build --progress plain --squash -t mlupin/docker-lambda:nodejs18.x-build-x86_64 .
