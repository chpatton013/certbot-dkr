#!/usr/bin/env python3

import argparse
import os
import pathlib
import subprocess
import sys

OUTPUT = "/var/lib/key-server"
REPO_ROOT = os.path.abspath(os.path.dirname(__file__))


def run(*args, **kwargs):
    return subprocess.check_call(args, **kwargs)


def create_directories(output):
    directories = [
        os.path.join(output, "etc"),
        os.path.join(output, "var", "lib"),
        os.path.join(output, "var", "log"),
    ]
    for d in directories:
        pathlib.Path(d).mkdir(parents=True, exist_ok=True)


def create_account(output, email):
    certbot_account_dir = os.path.join(output, "etc", "accounts")

    if os.path.exists(certbot_account_dir):
        print("Certbot accounts directory already exists.")
        return

    if not email:
        print("No certbot email specified.", file=sys.stderr)
        sys.exit(1)

    print("Registering certbot account")

    run(
        os.path.join(REPO_ROOT, "certbot.sh"),
        ".",
        output,
        "register",
        "--non-interactive",
        "--agree-tos",
        "--email",
        email,
    )


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default=OUTPUT)
    parser.add_argument("--email", default=None)
    args = parser.parse_args()

    output = os.path.abspath(args.output)

    create_directories(output)
    create_account(output, args.email)


if __name__ == "__main__":
    main()
