#!/usr/bin/env bash

set -euo pipefail

echo "Dumping all Amazon Linux 2 lambda environments"
sleep 1

for lambda in $(serverless deploy list functions | grep 'dump-'); do
    echo "Invoking ${lambda}…"
    serverless invoke -f $lambda -l
done

echo "All done."
