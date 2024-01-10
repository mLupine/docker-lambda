#!/usr/bin/env bash

set -euo pipefail
wget -q https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip
unzip pup_v0.4.0_linux_amd64.zip
curl -s https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html \
    | ./pup '.table-container' | ./pup ':parent-of(:parent-of(:parent-of(:parent-of(:contains("Supported")))))' \
    | ./pup 'tbody code text{}' | sed '/^[[:space:]]*$/d'  | tr -d ' ' | awk '{
    if ($0 ~ /provided/) {
        next
    }
    # Find the position where the first digit occurs
    match($0, /[0-9]/)
    start = RSTART

    # Extract the runtime and version
    RUNTIME = substr($0, 1, start - 1)
    VERSION = substr($0, start)

    # Remove unwanted endings
    gsub(/\.(x|al[0-9]*)$/, "", VERSION)

    print "Runtime: " RUNTIME " Version: " VERSION
}' > runtimes.txt
rm -rf pup*