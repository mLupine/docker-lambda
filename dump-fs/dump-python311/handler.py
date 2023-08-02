from __future__ import print_function

import json
import os
import subprocess
import sys

import boto3
from boto3.s3.transfer import S3Transfer

TRANSFER = S3Transfer(boto3.client("s3"))


def lambda_handler_arm64(event, context):
    return lambda_handler(event, context, "arm64")


def lambda_handler_x86_64(event, context):
    return lambda_handler(event, context, "x86_64")


def lambda_handler(event, context, arch):
    if "cmd" in event:
        return print(subprocess.check_output(["sh", "-c", event["cmd"]]).decode("utf-8"))

    filename = f"python3.11-{arch}.tgz"

    subprocess.call(["touch", f"/tmp/{filename}"])

    subprocess.call(
        [
            "sh",
            "-c",
            f"tar -cpzf /tmp/{filename} --numeric-owner --ignore-failed-read " + "/var/runtime /var/lang /var/rapid",
        ]
    )

    print("Zipping done! Uploading...")

    TRANSFER.upload_file(f"/tmp/{filename}", "docker-lambda", f"fs/{filename}", extra_args={"ACL": "public-read"})

    print("Uploading done!")

    info = {
        "sys.executable": sys.executable,
        "sys.argv": sys.argv,
        "sys.path": sys.path,
        "os.getcwd": os.getcwd(),
        "__file__": __file__,
        "os.environ": {k: str(v) for k, v in os.environ.items()},
        "context": {k: str(v) for k, v in context.__dict__.items()},
        "proc environ": subprocess.check_output(["sh", "-c", "echo /proc/1/environ; xargs -n 1 -0 < /proc/1/environ"])
        .decode("utf-8")
        .splitlines(),
        "ps aux": subprocess.check_output(
            [
                "bash",
                "-O",
                "extglob",
                "-c",
                "for cmd in /proc/+([0-9])/cmdline; do echo $cmd; xargs -n 1 -0 < $cmd; done",
            ]
        )
        .decode("utf-8")
        .splitlines(),
    }

    print(json.dumps(info, indent=2))

    return info
