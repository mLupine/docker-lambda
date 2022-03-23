# docker-lambda

A sandboxed local environment that replicates the live [AWS Lambda](https://aws.amazon.com/lambda/)
environment almost identically – including installed software and libraries,
file structure and permissions, environment variables, context objects and
behaviors – even the user and running process are the same.

<img src="https://raw.githubusercontent.com/mlupine/docker-lambda/master/examples/terminal.png" width="969" alt="Example usage with Python3.9-x86_64 runtime">

This is a partially rewritten and maintained fork of the original [LambCI](https://github.com/lambci/docker-lambda) project,
updated to include latest AWS Lambda runtimes and arm64 support. However, this fork dropped support for old, Amazon Linux 1-based
runtimes.

The images are hosted on:
* [Docker Hub](https://hub.docker.com/r/mlupin/docker-lambda)
* [GitHub Container Repository](https://github.com/mLupine/docker-lambda/pkgs/container/docker-lambda)

You can use it for [running your functions](#run-examples) in the same strict Lambda environment,
knowing that they'll exhibit the same behavior when deployed live. You can
also use it to [compile native dependencies](#build-examples) knowing that you're linking to the
same library versions that exist on AWS Lambda and then deploy using
the [AWS CLI](https://aws.amazon.com/cli/).

---

## Contents

- [docker-lambda](#docker-lambda)
  - [Contents](#contents)
  - [Docker tags](#docker-tags)
    - [nodejs12.x](#nodejs12x)
    - [nodejs14.x](#nodejs14x)
    - [python3.8](#python38)
    - [python3.9](#python39)
    - [ruby2.7](#ruby27)
    - [java8.al2](#java8al2)
    - [java11](#java11)
    - [dotnetcore3.1](#dotnetcore31)
    - [dotnet6](#dotnet6)
    - [provided.al2](#providedal2)
  - [Usage](#usage)
    - [Running Lambda functions](#running-lambda-functions)
      - [Running in "stay-open" API mode](#running-in-stay-open-api-mode)
      - [Developing in "stay-open" mode](#developing-in-stay-open-mode)
    - [Building Lambda functions](#building-lambda-functions)
  - [Run Examples](#run-examples)
  - [Build Examples](#build-examples)
  - [Using a Dockerfile to build](#using-a-dockerfile-to-build)
  - [Node.js module](#nodejs-module)
  - [Environment variables](#environment-variables)
  - [Build environment](#build-environment)
  - [Questions](#questions)

---

## Docker tags

### nodejs12.x

Runtime images

| Platform  | Docker Hub                               | GitHub Container Registry                         |
| --------- | ---------------------------------------- | ------------------------------------------------- |
| Universal | `mlupin/docker-lambda:nodejs12.x`        | `ghcr.io/mlupine/docker-lambda:nodejs12.x`        |
| x86_64    | `mlupin/docker-lambda:nodejs12.x-x86_64` | `ghcr.io/mlupine/docker-lambda:nodejs12.x-x86_64` |
| arm64     | `mlupin/docker-lambda:nodejs12.x-arm64`  | `ghcr.io/mlupine/docker-lambda:nodejs12.x-arm64`  |

Build images

| Platform  | Docker Hub                                     | GitHub Container Registry                               |
| --------- | ---------------------------------------------- | ------------------------------------------------------- |
| Universal | `mlupin/docker-lambda:nodejs12.x-build`        | `ghcr.io/mlupine/docker-lambda:nodejs12.x-build`        |
| x86_64    | `mlupin/docker-lambda:nodejs12.x-build-x86_64` | `ghcr.io/mlupine/docker-lambda:nodejs12.x-build-x86_64` |
| arm64     | `mlupin/docker-lambda:nodejs12.x-build-arm64`  | `ghcr.io/mlupine/docker-lambda:nodejs12.x-build-arm64`  |

### nodejs14.x

Runtime images

| Platform  | Docker Hub                               | GitHub Container Registry                         |
| --------- | ---------------------------------------- | ------------------------------------------------- |
| Universal | `mlupin/docker-lambda:nodejs14.x`        | `ghcr.io/mlupine/docker-lambda:nodejs14.x`        |
| x86_64    | `mlupin/docker-lambda:nodejs14.x-x86_64` | `ghcr.io/mlupine/docker-lambda:nodejs14.x-x86_64` |
| arm64     | `mlupin/docker-lambda:nodejs14.x-arm64`  | `ghcr.io/mlupine/docker-lambda:nodejs14.x-arm64`  |

Build images

| Platform  | Docker Hub                                     | GitHub Container Registry                               |
| --------- | ---------------------------------------------- | ------------------------------------------------------- |
| Universal | `mlupin/docker-lambda:nodejs14.x-build`        | `ghcr.io/mlupine/docker-lambda:nodejs14.x-build`        |
| x86_64    | `mlupin/docker-lambda:nodejs14.x-build-x86_64` | `ghcr.io/mlupine/docker-lambda:nodejs14.x-build-x86_64` |
| arm64     | `mlupin/docker-lambda:nodejs14.x-build-arm64`  | `ghcr.io/mlupine/docker-lambda:nodejs14.x-build-arm64`  |

### python3.8

Runtime images

| Platform  | Docker Hub                              | GitHub Container Registry                        |
| --------- | --------------------------------------- | ------------------------------------------------ |
| Universal | `mlupin/docker-lambda:python3.8`        | `ghcr.io/mlupine/docker-lambda:python3.8`        |
| x86_64    | `mlupin/docker-lambda:python3.8-x86_64` | `ghcr.io/mlupine/docker-lambda:python3.8-x86_64` |
| arm64     | `mlupin/docker-lambda:python3.8-arm64`  | `ghcr.io/mlupine/docker-lambda:python3.8-arm64`  |

Build images

| Platform  | Docker Hub                                    | GitHub Container Registry                              |
| --------- | --------------------------------------------- | ------------------------------------------------------ |
| Universal | `mlupin/docker-lambda:python3.8-build`        | `ghcr.io/mlupine/docker-lambda:python3.8-build`        |
| x86_64    | `mlupin/docker-lambda:python3.8-build-x86_64` | `ghcr.io/mlupine/docker-lambda:python3.8-build-x86_64` |
| arm64     | `mlupin/docker-lambda:python3.8-build-arm64`  | `ghcr.io/mlupine/docker-lambda:python3.8-build-arm64`  |

### python3.9

Runtime images

| Platform  | Docker Hub                              | GitHub Container Registry                        |
| --------- | --------------------------------------- | ------------------------------------------------ |
| Universal | `mlupin/docker-lambda:python3.9`        | `ghcr.io/mlupine/docker-lambda:python3.9`        |
| x86_64    | `mlupin/docker-lambda:python3.9-x86_64` | `ghcr.io/mlupine/docker-lambda:python3.9-x86_64` |
| arm64     | `mlupin/docker-lambda:python3.9-arm64`  | `ghcr.io/mlupine/docker-lambda:python3.9-arm64`  |

Build images

| Platform  | Docker Hub                                    | GitHub Container Registry                              |
| --------- | --------------------------------------------- | ------------------------------------------------------ |
| Universal | `mlupin/docker-lambda:python3.9-build`        | `ghcr.io/mlupine/docker-lambda:python3.9-build`        |
| x86_64    | `mlupin/docker-lambda:python3.9-build-x86_64` | `ghcr.io/mlupine/docker-lambda:python3.9-build-x86_64` |
| arm64     | `mlupin/docker-lambda:python3.9-build-arm64`  | `ghcr.io/mlupine/docker-lambda:python3.9-build-arm64`  |

### ruby2.7

Runtime images

| Platform  | Docker Hub                            | GitHub Container Registry                      |
| --------- | ------------------------------------- | ---------------------------------------------- |
| Universal | `mlupin/docker-lambda:ruby2.7`        | `ghcr.io/mlupine/docker-lambda:ruby2.7`        |
| x86_64    | `mlupin/docker-lambda:ruby2.7-x86_64` | `ghcr.io/mlupine/docker-lambda:ruby2.7-x86_64` |
| arm64     | `mlupin/docker-lambda:ruby2.7-arm64`  | `ghcr.io/mlupine/docker-lambda:ruby2.7-arm64`  |

Build images

| Platform  | Docker Hub                                  | GitHub Container Registry                            |
| --------- | ------------------------------------------- | ---------------------------------------------------- |
| Universal | `mlupin/docker-lambda:ruby2.7-build`        | `ghcr.io/mlupine/docker-lambda:ruby2.7-build`        |
| x86_64    | `mlupin/docker-lambda:ruby2.7-build-x86_64` | `ghcr.io/mlupine/docker-lambda:ruby2.7-build-x86_64` |
| arm64     | `mlupin/docker-lambda:ruby2.7-build-arm64`  | `ghcr.io/mlupine/docker-lambda:ruby2.7-build-arm64`  |

### java8.al2

Runtime images

| Platform  | Docker Hub                              | GitHub Container Registry                        |
| --------- | --------------------------------------- | ------------------------------------------------ |
| Universal | `mlupin/docker-lambda:java8.al2`        | `ghcr.io/mlupine/docker-lambda:java8.al2`        |
| x86_64    | `mlupin/docker-lambda:java8.al2-x86_64` | `ghcr.io/mlupine/docker-lambda:java8.al2-x86_64` |
| arm64     | `mlupin/docker-lambda:java8.al2-arm64`  | `ghcr.io/mlupine/docker-lambda:java8.al2-arm64`  |

Build images

| Platform  | Docker Hub                                    | GitHub Container Registry                              |
| --------- | --------------------------------------------- | ------------------------------------------------------ |
| Universal | `mlupin/docker-lambda:java8.al2-build`        | `ghcr.io/mlupine/docker-lambda:java8.al2-build`        |
| x86_64    | `mlupin/docker-lambda:java8.al2-build-x86_64` | `ghcr.io/mlupine/docker-lambda:java8.al2-build-x86_64` |
| arm64     | `mlupin/docker-lambda:java8.al2-build-arm64`  | `ghcr.io/mlupine/docker-lambda:java8.al2-build-arm64`  |

### java11

Runtime images

| Platform  | Docker Hub                           | GitHub Container Registry                     |
| --------- | ------------------------------------ | --------------------------------------------- |
| Universal | `mlupin/docker-lambda:java11`        | `ghcr.io/mlupine/docker-lambda:java11`        |
| x86_64    | `mlupin/docker-lambda:java11-x86_64` | `ghcr.io/mlupine/docker-lambda:java11-x86_64` |
| arm64     | `mlupin/docker-lambda:java11-arm64`  | `ghcr.io/mlupine/docker-lambda:java11-arm64`  |

Build images

| Platform  | Docker Hub                                 | GitHub Container Registry                           |
| --------- | ------------------------------------------ | --------------------------------------------------- |
| Universal | `mlupin/docker-lambda:java11-build`        | `ghcr.io/mlupine/docker-lambda:java11-build`        |
| x86_64    | `mlupin/docker-lambda:java11-build-x86_64` | `ghcr.io/mlupine/docker-lambda:java11-build-x86_64` |
| arm64     | `mlupin/docker-lambda:java11-build-arm64`  | `ghcr.io/mlupine/docker-lambda:java11-build-arm64`  |

### dotnetcore3.1

Runtime images

| Platform  | Docker Hub                                  | GitHub Container Registry                            |
| --------- | ------------------------------------------- | ---------------------------------------------------- |
| Universal | `mlupin/docker-lambda:dotnetcore3.1`        | `ghcr.io/mlupine/docker-lambda:dotnetcore3.1`        |
| x86_64    | `mlupin/docker-lambda:dotnetcore3.1-x86_64` | `ghcr.io/mlupine/docker-lambda:dotnetcore3.1-x86_64` |
| arm64     | `mlupin/docker-lambda:dotnetcore3.1-arm64`  | `ghcr.io/mlupine/docker-lambda:dotnetcore3.1-arm64`  |

Build images

| Platform  | Docker Hub                                        | GitHub Container Registry                                  |
| --------- | ------------------------------------------------- | ---------------------------------------------------------- |
| Universal | `mlupin/docker-lambda:dotnetcore3.1-build`        | `ghcr.io/mlupine/docker-lambda:dotnetcore3.1-build`        |
| x86_64    | `mlupin/docker-lambda:dotnetcore3.1-build-x86_64` | `ghcr.io/mlupine/docker-lambda:dotnetcore3.1-build-x86_64` |
| arm64     | `mlupin/docker-lambda:dotnetcore3.1-build-arm64`  | `ghcr.io/mlupine/docker-lambda:dotnetcore3.1-build-arm64`  |

### dotnet6

Runtime images

| Platform  | Docker Hub                                  | GitHub Container Registry                            |
| --------- | ------------------------------------------- | ---------------------------------------------------- |
| Universal | `mlupin/docker-lambda:dotnet6`              | `ghcr.io/mlupine/docker-lambda:dotnet6`              |
| x86_64    | `mlupin/docker-lambda:dotnet6-x86_64`       | `ghcr.io/mlupine/docker-lambda:dotnet6-x86_64`       |
| arm64     | `mlupin/docker-lambda:dotnet6-arm64`        | `ghcr.io/mlupine/docker-lambda:dotnet6-arm64`        |

Build images

| Platform  | Docker Hub                                        | GitHub Container Registry                                  |
| --------- | ------------------------------------------------- | ---------------------------------------------------------- |
| Universal | `mlupin/docker-lambda:dotnet6-build`              | `ghcr.io/mlupine/docker-lambda:dotnet6-build`              |
| x86_64    | `mlupin/docker-lambda:dotnet6-build-x86_64`       | `ghcr.io/mlupine/docker-lambda:dotnet6-build-x86_64`       |
| arm64     | `mlupin/docker-lambda:dotnet6-build-arm64`        | `ghcr.io/mlupine/docker-lambda:dotnet6-build-arm64`        |

### provided.al2

Runtime images

| Platform  | Docker Hub                                 | GitHub Container Registry                           |
| --------- | ------------------------------------------ | --------------------------------------------------- |
| Universal | `mlupin/docker-lambda:provided.al2`        | `ghcr.io/mlupine/docker-lambda:provided.al2`        |
| x86_64    | `mlupin/docker-lambda:provided.al2-x86_64` | `ghcr.io/mlupine/docker-lambda:provided.al2-x86_64` |
| arm64     | `mlupin/docker-lambda:provided.al2-arm64`  | `ghcr.io/mlupine/docker-lambda:provided.al2-arm64`  |

Build images

| Platform  | Docker Hub                                       | GitHub Container Registry                                 |
| --------- | ------------------------------------------------ | --------------------------------------------------------- |
| Universal | `mlupin/docker-lambda:provided.al2-build`        | `ghcr.io/mlupine/docker-lambda:provided.al2-build`        |
| x86_64    | `mlupin/docker-lambda:provided.al2-build-x86_64` | `ghcr.io/mlupine/docker-lambda:provided.al2-build-x86_64` |
| arm64     | `mlupin/docker-lambda:provided.al2-build-arm64`  | `ghcr.io/mlupine/docker-lambda:provided.al2-build-arm64`  |


Each tag can be suffixed with the architecture it's meant to be run on. Otherwise, Docker will use the
architecture matching the host system. For example:
```sh
# This will always execute the code in an x86_64 evironment (native on x86 computers, emulated on arm64)
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:nodejs12.x-x86_64 index.handler

# This will always execute the code in an arm64 evironment (native on arm64 computers, emulated on x86)
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:nodejs12.x-arm64 index.handler

# This will always execute the code in an evironment matching the host computer architecture
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:nodejs12.x index.handler
```

You might see the following message when trying to run a container built for an architecture different than your host:
```
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm/v8) and no specific platform was requested
```

In that case, you need to install QEMU bindings on your machine so that containers can be emulated properly. To do that,
simply execute the following command once:
```sh
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

Keep in mind that running emulated arm64 images on x86 machines and vice-versa is going to be painfully slow.

## Usage

### Running Lambda functions

You can run your Lambdas from local directories using the `-v` arg with
`docker run`. You can run them in two modes: as a single execution, or as
[an API server that listens for invoke events](#running-in-stay-open-api-mode).
The default is single execution mode, which outputs all logging to stderr and the result of the handler to stdout.

You mount your (unzipped) lambda code at `/var/task` and any (unzipped) layer
code at `/opt`, and most runtimes take two arguments – the first for the
handler and the second for the event, ie:

```sh
docker run --rm \
  -v <code_dir>:/var/task:ro,delegated \
  [-v <layer_dir>:/opt:ro,delegated] \
  mlupin/docker-lambda:<runtime> \
  [<handler>] [<event>]
```

(the `--rm` flag will remove the docker container once it has run, which is usually what you want,
and the `ro,delegated` options ensure the directories are mounted read-only and have the highest performance)

You can pass environment variables (eg `-e AWS_ACCESS_KEY_ID=abcd`) to talk to live AWS services,
or modify aspects of the runtime. See [below](#environment-variables) for a list.

#### Running in "stay-open" API mode

If you pass the environment variable `DOCKER_LAMBDA_STAY_OPEN=1` to the container, then instead of
executing the event and shutting down, it will start an API server (on port 9001 by default), which
you can then call with HTTP following the [Lambda Invoke API](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html).
This allows you to make fast subsequent calls to your handler without paying the "cold start" penalty each time.

```sh
docker run --rm [-d] \
  -e DOCKER_LAMBDA_STAY_OPEN=1 \
  -p 9001:9001 \
  -v <code_dir>:/var/task:ro,delegated \
  [-v <layer_dir>:/opt:ro,delegated] \
  mlupin/docker-lambda:<runtime> \
  [<handler>]
```

(the `-d` flag will start the container in detached mode, in the background)

You should then see:

```sh
Lambda API listening on port 9001...
```

Then, in another terminal shell/window you can invoke your function using the [AWS CLI](https://aws.amazon.com/cli/)
(or any http client, like `curl`):

```sh
aws lambda invoke --endpoint http://localhost:9001 --no-sign-request \
  --function-name myfunction --payload '{}' output.json
```

(if you're using [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/cliv2-migration.html#cliv2-migration-binaryparam), you'll need to add `--cli-binary-format raw-in-base64-out` to the above command)

Or just:

```sh
curl -d '{}' http://localhost:9001/2015-03-31/functions/myfunction/invocations
```

It also supports the [documented Lambda API headers](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html)
`X-Amz-Invocation-Type`, `X-Amz-Log-Type` and `X-Amz-Client-Context`.

If you want to change the exposed port, eg run on port 3000 on the host, use `-p 3000:9001` (then query `http://localhost:3000`).

You can change the internal Lambda API port from `9001` by passing `-e DOCKER_LAMBDA_API_PORT=<port>`.
You can also change the [custom runtime](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html#runtimes-custom-build)
port from `9001` by passing `-e DOCKER_LAMBDA_RUNTIME_PORT=<port>`.

#### Developing in "stay-open" mode

docker-lambda can watch for changes to your handler (and layer) code and restart the internal bootstrap process
so you can always invoke the latest version of your code without needing to shutdown the container.

To enable this, pass `-e DOCKER_LAMBDA_WATCH=1` to `docker run`:

```
docker run --rm \
  -e DOCKER_LAMBDA_WATCH=1 -e DOCKER_LAMBDA_STAY_OPEN=1 -p 9001:9001 \
  -v "$PWD":/var/task:ro,delegated \
  mlupin/docker-lambda:java11 handler
```

Then when you make changes to any file in the mounted directory, you'll see:

```
Handler/layer file changed, restarting bootstrap...
```

And the next invoke will reload your handler with the latest version of your code.

### Building Lambda functions

The build images have a [number of extra system packages installed](#build-environment)
intended for building and packaging your Lambda functions. You can run your build commands (eg, `gradle` on the java image), and then package up your function using `zip` or the
[AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html),
all from within the image.

```sh
docker run [--rm] -v <code_dir>:/var/task [-v <layer_dir>:/opt] mlupin/docker-lambda:<runtime>-build[-<arch>] <build-cmd>
```

## Run Examples

```sh
# Test a `handler` function from an `index.js` file in the current directory on Node.js v12.x
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:nodejs12.x index.handler

# Test a `handler` function from an `index.js` file in the current directory on Node.js v12.x; image downloaded from GitHub Container Repo
docker run --rm -v "$PWD":/var/task:ro,delegated ghcr.io/mlupine/docker-lambda:nodejs12.x index.handler

# Test a `handler` function from an `index.js` file in the current directory on Node.js v12.x, forcing x86_64 arch to be used
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:nodejs12.x-x86_64 index.handler

# Using a different file and handler, with a custom event
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:nodejs12.x app.myHandler '{"some": "event"}'

# Test a `lambda_handler` function in `lambda_function.py` with an empty event on Python 3.8
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:python3.8 lambda_function.lambda_handler

# Similarly with Ruby 2.7
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:ruby2.7 lambda_function.lambda_handler

# Test a function from the current directory on Java 11
# The directory must be laid out in the same way the Lambda zip file is,
# with top-level package source directories and a `lib` directory for third-party jars
# https://docs.aws.amazon.com/lambda/latest/dg/java-package.html
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:java11 org.myorg.MyHandler

# Test on .NET Core 3.1 given a test.dll assembly in the current directory,
# a class named Function with a FunctionHandler method, and a custom event
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:dotnetcore3.1 test::test.Function::FunctionHandler '{"some": "event"}'

# Test with a provided runtime (assumes you have a `bootstrap` executable in the current directory)
docker run --rm -v "$PWD":/var/task:ro,delegated mlupin/docker-lambda:provided.al2 handler '{"some": "event"}'

# Test with layers (assumes your function code is in `./fn` and your layers in `./layer`)
docker run --rm -v "$PWD"/fn:/var/task:ro,delegated -v "$PWD"/layer:/opt:ro,delegated mlupin/docker-lambda:nodejs12.x

# Run custom commands
docker run --rm --entrypoint node mlupin/docker-lambda:nodejs12.x -v

# For large events you can pipe them into stdin if you set DOCKER_LAMBDA_USE_STDIN
echo '{"some": "event"}' | docker run --rm -v "$PWD":/var/task:ro,delegated -i -e DOCKER_LAMBDA_USE_STDIN=1 mlupin/docker-lambda:nodejs12.x
```

You can see more examples of how to build docker images and run different
runtimes in the [examples](./examples) directory.

## Build Examples

To use the build images, for compilation, deployment, etc:

```sh
# To compile native deps in node_modules
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:nodejs12.x-build npm rebuild --build-from-source

# To compile native deps in node_modules for a specific architecture
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:nodejs12.x-build-x86_64 npm rebuild --build-from-source
# or
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:nodejs12.x-build-arm64 npm rebuild --build-from-source

# To install defined poetry dependencies
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:python3.8-build poetry install

# For .NET Core, this will publish the compiled code to `./pub`,
# which you can then use to run with `-v "$PWD"/pub:/var/task`
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:dotnetcore3.1-build dotnet publish -c Release -o pub

# Run custom commands on a build container
docker run --rm mlupin/docker-lambda:python3.8-build aws --version

# To run an interactive session on a build container
docker run -it mlupin/docker-lambda:python3.8-build bash
```

## Using a Dockerfile to build

Create your own Docker image to build and deploy:

```dockerfile
FROM mlupin/docker-lambda:nodejs12.x-build

ENV AWS_DEFAULT_REGION us-east-1

COPY . .

RUN npm install

RUN zip -9yr lambda.zip .

CMD aws lambda update-function-code --function-name mylambda --zip-file fileb://lambda.zip
```

And then:

```sh
docker build -t mylambda .
docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY mylambda
```

## Node.js module

Using the Node.js module (`npm install docker-lambda`) – for example in tests:

```js
var dockerLambda = require('docker-lambda')

// Spawns synchronously, uses current dir – will throw if it fails
var lambdaCallbackResult = dockerLambda({event: {some: 'event'}, dockerImage: 'mlupin/docker-lambda:nodejs12.x'})

// Manually specify directory and custom args
lambdaCallbackResult = dockerLambda({taskDir: __dirname, dockerArgs: ['-m', '1.5G'], dockerImage: 'mlupin/docker-lambda:nodejs12.x'})
```

Options to pass to `dockerLambda()`:
  - `dockerImage`
  - `handler`
  - `event`
  - `taskDir`
  - `cleanUp`
  - `addEnvVars`
  - `dockerArgs`
  - `spawnOptions`
  - `returnSpawnResult`

## Environment variables

  - `AWS_LAMBDA_FUNCTION_HANDLER` or `_HANDLER`
  - `AWS_LAMBDA_EVENT_BODY`
  - `AWS_LAMBDA_FUNCTION_NAME`
  - `AWS_LAMBDA_FUNCTION_VERSION`
  - `AWS_LAMBDA_FUNCTION_INVOKED_ARN`
  - `AWS_LAMBDA_FUNCTION_MEMORY_SIZE`
  - `AWS_LAMBDA_FUNCTION_TIMEOUT`
  - `AWS_EXECUTION_ENV`
  - `AWS_EXECUTION_ARCH`
  - `_X_AMZN_TRACE_ID`
  - `AWS_REGION` or `AWS_DEFAULT_REGION`
  - `AWS_ACCOUNT_ID`
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_SESSION_TOKEN`
  - `DOCKER_LAMBDA_USE_STDIN`
  - `DOCKER_LAMBDA_STAY_OPEN`
  - `DOCKER_LAMBDA_API_PORT`
  - `DOCKER_LAMBDA_RUNTIME_PORT`
  - `DOCKER_LAMBDA_DEBUG`
  - `DOCKER_LAMBDA_NO_MODIFY_LOGS`

## Build environment

Yum packages installed on build images:

  - `development` (group, includes `gcc-c++`, `autoconf`, `automake`, `git`, `vim`, etc)
  - `aws-cli`
  - `aws-sam-cli`
  - `docker` (Docker in Docker!)
  - `clang`
  - `cmake`

## Questions

* *When should I use this?*

  When you want fast local reproducibility. When you don't want to spin up an
  Amazon Linux EC2 instance (indeed, network aside, this is closer to the real
  Lambda environment because there are a number of different files, permissions
  and libraries on a default Amazon Linux instance). When you don't want to
  invoke a live Lambda just to test your Lambda package – you can do it locally
  from your dev machine or run tests on your CI system (assuming it has Docker
  support!)


* *Wut, how?*

  By [tarring the full filesystem in Lambda, uploading that to S3](./dump-fs),
  and then [piping into Docker to create a new image from scratch](./base) –
  then [creating mock modules](./runtimes/provided.al2-x86_64/run/init.go) that will be
  required/included in place of the actual native modules that communicate with
  the real Lambda coordinating services.  Only the native modules are mocked
  out – the actual parent JS/PY/Java runner files are left alone, so their behaviors
  don't need to be replicated (like the overriding of `console.log`, and custom
  defined properties like `callbackWaitsForEmptyEventLoop`)

* *What's missing from the images?*

  Hard to tell – anything that's not readable – so at least `/root/*` –
  but probably a little more than that – hopefully nothing important, after all,
  it's not readable by Lambda, so how could it be!

* *Is it really necessary to replicate exactly to this degree?*

  Not for many scenarios – some compiled Linux binaries work out of the box
  and an Amazon Linux Docker image can compile some binaries that work on
  Lambda too, for example – but for testing it's great to be able to reliably
  verify permissions issues, library linking issues, etc.

* *How is this fork better than the upstream LambCI repo?*

  Well, it's maintained, that's the most obvious difference. I've also rewritten
  some parts of the code to make further development easier and added support for
  runtimes that were not supported in the original repo. I've also added support
  for arm64 Lambdas, which is a great addition for anyone who wants to migrate
  their functions to the newer architecture but was struggling to test and build
  ARM dependencies locally.

* *Why drop Amazon Linux 1 support?*

  None of those AL1-based enviornments are going to get any upgrades and the images
  in the original repo still work just fine. There was no need to reinvent the wheel
  and create them again.

* *There is a new Lambda runtime and it's not supported by this project!*

  I probably missed the fact that it was released, or I'm already working on getting
  it implemented. In any case, feel free to create an issue and I'll do my best to add
  it ASAP.
