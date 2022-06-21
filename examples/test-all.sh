#!/bin/bash

set -euxo pipefail

export EXAMPLES_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

cd ${EXAMPLES_DIR}/nodejs
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:nodejs12.x index.handler
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:nodejs14.x index.handler
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:nodejs16.x index.handler

cd ${EXAMPLES_DIR}/nodejs-native-module
npm install
npm run build
npm test

cd ${EXAMPLES_DIR}/python
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:python3.8 lambda_function.lambda_handler
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:python3.9 lambda_function.lambda_handler

cd ${EXAMPLES_DIR}/python
docker run --rm -it mlupin/docker-lambda:python3.8-build pip install marisa-trie
docker run --rm -it mlupin/docker-lambda:python3.9-build pip install marisa-trie

cd ${EXAMPLES_DIR}/ruby
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:ruby2.7 lambda_function.lambda_handler

cd ${EXAMPLES_DIR}/java
docker run --rm -v "$PWD":/app -w /app mlupin/docker-lambda:java8.al2-build gradle build
docker run --rm -v "$PWD/build/docker":/var/task mlupin/docker-lambda:java8.al2 pl.lupin.lambda.ExampleHandler '{"some": "event"}'
docker run --rm -v "$PWD/build/docker":/var/task mlupin/docker-lambda:java11 pl.lupin.lambda.ExampleHandler '{"some": "event"}'

cd ${EXAMPLES_DIR}/dotnetcore3.1
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:dotnetcore3.1-build dotnet publish -c Release -o pub
docker run --rm -v "$PWD"/pub:/var/task mlupin/docker-lambda:dotnetcore3.1 test::test.Function::FunctionHandler '{"some": "event"}'

cd ${EXAMPLES_DIR}/dotnet6
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:dotnet6-build dotnet publish -c Release -o pub
docker run --rm -v "$PWD"/pub:/var/task mlupin/docker-lambda:dotnet6 test::test.Function::FunctionHandler '{"some": "event"}'

cd ${EXAMPLES_DIR}/provided.al2
docker run --rm -v "$PWD":/go -w /go golang:1 sh -c 'unset GOPATH && go mod download && go build -tags lambda.norpc bootstrap.go'
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:provided.al2 handler '{"Records": []}'
