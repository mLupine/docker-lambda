#!/bin/sh

curl https://docker-lambda.s3.amazonaws.com/fs/base-2-arm64.tgz | tar -xz --strip-components=2 -- var/lib/rpm

docker pull arm64v8/amazonlinux:2
docker run -v "$PWD/rpm":/rpm --rm arm64v8/amazonlinux:2 rpm -qa --dbpath /rpm | grep -v ^gpg-pubkey- | sort > packages.txt
rm -rf rpm

docker run --rm arm64v8/amazonlinux:2 bash -c 'yum upgrade -y > /dev/null && rpm -qa' | grep -v ^gpg-pubkey- | sort > amazonlinux2.txt

if diff -w -d amazonlinux2.txt packages.txt | grep -q '>'; then
  echo 'Mismatching packages on images'
  diff -w -d amazonlinux2.txt packages.txt
else
  diff -w -d amazonlinux2.txt packages.txt | grep '<' | awk '{print $2}' > diff.txt
fi
