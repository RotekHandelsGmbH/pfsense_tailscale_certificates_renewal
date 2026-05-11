#!/bin/bash
host=$(basename "$(dirname "$(readlink -f "$0")")")
exec ssh root@"$host" -i /home/srvadmin/.ssh/root@anyhost_nopass.key
