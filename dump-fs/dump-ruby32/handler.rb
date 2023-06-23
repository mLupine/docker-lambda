require 'json'
require 'aws-sdk-s3'

S3_CLIENT = Aws::S3::Client.new({region: "eu-central-1"})

def lambda_handler(event, context, arch)
  filename = "ruby3.2-#{arch}.tgz"

  puts `touch /tmp/#{filename}`
  puts `tar -cpzf /tmp/#{filename} --numeric-owner --ignore-failed-read /var/runtime /var/lang /var/rapid`

  File.open("/tmp/#{filename}", 'rb') do |file|
    S3_CLIENT.put_object({
      body: file,
      bucket: 'docker-lambda',
      key: "fs/#{filename}",
      acl: 'public-read',
    })
  end

  info = {
    'ENV' => ENV.to_hash,
    'context' => context.instance_variables.each_with_object({}) { |k, h| h[k] = context.instance_variable_get k },
    'ps aux' => `bash -O extglob -c 'for cmd in /proc/+([0-9])/cmdline; do echo $cmd; xargs -n 1 -0 < $cmd; done'`,
    'proc environ' => `xargs -n 1 -0 < /proc/1/environ`,
  }

  print JSON.pretty_generate(info)

  return info
end


def lambda_handler_x86_64(event:, context:)
  return lambda_handler event, context, "x86_64"
end

def lambda_handler_arm64(event:, context:)
  return lambda_handler event, context, "arm64"
end
