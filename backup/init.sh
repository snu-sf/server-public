#!/usr/bin/env bash

for server in `cat servers`; do
    echo $server
    ssh $server git clone https://github.com/snu-sf/server-public.git /root/server-public
done
