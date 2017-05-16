#!/usr/bin/env bash

for server in `cat servers`; do
    echo $server
    ssh $server "cd /root/server-public/cn; git pull; ./daily.sh"
done
