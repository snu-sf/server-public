#!/usr/bin/env bash

for server in `cat $(dirname "$0")/servers`; do
    echo $server
    ssh $server "cd /root/server-public; git pull; cd cn; ./daily.sh"
done
