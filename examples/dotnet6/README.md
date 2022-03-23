# .NET 6.0 docker-lambda example

```sh
# Will place the compiled code in `./pub`
docker run --rm -v "$PWD":/var/task mlupin/docker-lambda:build-dotnet6 dotnet publish -c Release -o pub

# Then you can run using that as the task directory
docker run --rm -v "$PWD"/pub:/var/task mlupin/docker-lambda:dotnet6 test::test.Function::FunctionHandler '{"some": "event"}'
```
