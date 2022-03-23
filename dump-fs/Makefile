.PHONY: clean build deploy dump-all

build-dotnetcore31-x86_64:
	mkdir -p ./bin
	docker run --rm -v "$(realpath ./dump-dotnetcore31):/tmp/build" -v "$(realpath ./bin):/tmp/bin" mcr.microsoft.com/dotnet/sdk:3.1-bullseye bash -c " \
		apt-get update && apt-get install -y zip && \
		cd /tmp/build && \
		dotnet restore && \
		dotnet tool install -g Amazon.Lambda.Tools --framework netcoreapp3.1 && \
		export PATH=\"$$PATH:/root/.dotnet/tools\" && \
		dotnet lambda package --configuration Release --framework netcoreapp3.1 --function-architecture x86_64 --output-package /tmp/bin/Release/dump-dotnetcore31/handler-x86_64.zip \
	"

build-dotnetcore31-arm64:
	mkdir -p ./bin
	docker run --rm -v "$(realpath ./dump-dotnetcore31):/tmp/build" -v "$(realpath ./bin):/tmp/bin" mcr.microsoft.com/dotnet/sdk:3.1-bullseye bash -c " \
		apt-get update && apt-get install -y zip && \
		cd /tmp/build && \
		dotnet restore && \
		dotnet tool install -g Amazon.Lambda.Tools --framework netcoreapp3.1 && \
		export PATH=\"$$PATH:/root/.dotnet/tools\" && \
		dotnet lambda package --configuration Release --framework netcoreapp3.1 --function-architecture arm64 --output-package /tmp/bin/Release/dump-dotnetcore31/handler-arm64.zip \
	"

build-dotnetcore31: build-dotnetcore31-x86_64 build-dotnetcore31-arm64

build-dotnet6-x86_64:
	mkdir -p ./bin
	docker run --rm -v "$(realpath ./dump-dotnet6):/tmp/build" -v "$(realpath ./bin):/tmp/bin" mcr.microsoft.com/dotnet/sdk:6.0 bash -c " \
		apt-get update && apt-get install -y zip && \
		cd /tmp/build && \
		dotnet restore && \
		dotnet tool install -g Amazon.Lambda.Tools --framework net6.0 && \
		export PATH=\"$$PATH:/root/.dotnet/tools\" && \
		dotnet lambda package --configuration Release --framework net6.0 --function-architecture x86_64 --output-package /tmp/bin/Release/dump-dotnet6/handler-x86_64.zip \
	"

build-dotnet6-arm64:
	mkdir -p ./bin
	docker run --rm -v "$(realpath ./dump-dotnet6):/tmp/build" -v "$(realpath ./bin):/tmp/bin" mcr.microsoft.com/dotnet/sdk:6.0 bash -c " \
		apt-get update && apt-get install -y zip && \
		cd /tmp/build && \
		dotnet restore && \
		dotnet tool install -g Amazon.Lambda.Tools --framework net6.0 && \
		export PATH=\"$$PATH:/root/.dotnet/tools\" && \
		dotnet lambda package --configuration Release --framework net6.0 --function-architecture arm64 --output-package /tmp/bin/Release/dump-dotnet6/handler-arm64.zip \
	"

build-dotnet6: build-dotnet6-x86_64 build-dotnet6-arm64

build-java8.al2:
	docker run --rm -v "$(realpath ./dump-java8.al2):/app" -w /app gradle:jdk8 gradle build
	cp -a dump-java8.al2/build/distributions/app.zip bin/dump-java8.al2-x86_64.zip
	cp -a dump-java8.al2/build/distributions/app.zip bin/dump-java8.al2-arm64.zip

build-java11:
	docker run --rm -v "$(realpath ./dump-java11):/app" -w /app gradle:jdk11 gradle build
	cp -a dump-java11/build/distributions/app.zip bin/dump-java11-x86_64.zip
	cp -a dump-java11/build/distributions/app.zip bin/dump-java11-arm64.zip

build-provided.al2-x86_64:
	export GO111MODULE=on && \
	cd dump-provided.al2/x86_64/ && go mod download
	cd dump-provided.al2/x86_64/ && env GOARCH=amd64 GOOS=linux go build -tags lambda.norpc -ldflags="-s -w" main.go
	mkdir -p bin/DumpProvidedAL2-x86_64
	mv dump-provided.al2/x86_64/main bin/DumpProvidedAL2-x86_64/bootstrap
	cd bin/DumpProvidedAL2-x86_64/ && zip -r ../DumpProvidedAL2-x86_64.zip *

build-provided.al2-arm64:
	export GO111MODULE=on && \
	cd dump-provided.al2/arm64/ && go mod download
	cd dump-provided.al2/arm64/ && env GOARCH=arm64 GOOS=linux go build -tags lambda.norpc -ldflags="-s -w" main.go
	mkdir -p bin/DumpProvidedAL2-arm64
	mv dump-provided.al2/arm64/main bin/DumpProvidedAL2-arm64/bootstrap
	cd bin/DumpProvidedAL2-arm64/ && zip -r ../DumpProvidedAL2-arm64.zip *

build-provided.al2: build-provided.al2-x86_64 build-provided.al2-arm64

build: build-dotnetcore31 build-dotnet6 build-java8.al2 build-java11 build-provided.al2

clean:
	rm -rf ./bin ./vendor

deploy: clean build
	sls deploy --verbose

dump-all:
	./dump-all.sh
