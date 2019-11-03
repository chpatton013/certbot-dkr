#!/usr/bin/env bash
set -euo pipefail

script_dir="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

input_dir="$(realpath "$1")"
output_dir="$(realpath "$2")"
shift 2

docker build --rm --tag=certbot "$script_dir" >&2
docker run \
  --volume="$input_dir:/usr/local/etc/certbot:ro" \
  --volume="$output_dir/etc:/etc/letsencrypt:rw" \
  --volume="$output_dir/var/lib:/var/lib/letsencrypt:rw" \
  --volume="$output_dir/var/log:/var/log/letsencrypt:rw" \
  certbot \
  "$@"
