#!/usr/bin/env bash
set -Eeu -o pipefail

ALLOWED_HOST="lxc-pydev"

log_info() {
  printf '%s [INFO] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >&2
}

CURRENT_HOST="$(hostname -s)"
if [[ "$CURRENT_HOST" != "$ALLOWED_HOST" ]]; then
  log_info "Refusing to run on '${CURRENT_HOST}': this script must be run from '${ALLOWED_HOST}'."
  exit 1
fi

host=$(basename "$(dirname "$(readlink -f "$0")")")
exec ssh root@"$host" -i /home/srvadmin/.ssh/root@anyhost_nopass.key
