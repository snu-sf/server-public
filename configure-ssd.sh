#!/usr/bin/env bash

GID=16777216

for username in `ls /home | grep "\."`; do
    uid=`stat -c '%u' /data/home/$username`
    gid=`stat -c '%g' /data/home/$username`

    if [ $gid = $GID ]; then
        mkdir -p /opt/devel/$username
        chown $uid:$gid /opt/devel/$username
    fi
done
