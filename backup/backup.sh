#!/usr/bin/bash

NOW=$(date +"%Y%m%dUTC%k%M")
ssh sn01-external rm -rf /data/backup/sn01/usbkey
ssh sn01-external cp -a /usbkey /data/backup/sn01/usbkey
ssh sn01-external zfs snapshot -r data@$NOW

for server in `cat servers`; do
    if rsync -e ssh -avzrc --delete root@$server:/opt/ /data/backup/$server/opt; then 
        echo "Backup complete @ $(date)" | ssh $server 'cat >> /opt/backup.log'
    else 
        echo "Backup failed @ $(date)" | ssh $server 'cat >> /opt/backup.log'
    fi
done
