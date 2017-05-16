#!/usr/bin/env bash

# execute like: curl -sL http://sf.snu.snu.ac.kr/root/cn-init.sh | bash -s

/usr/bin/yum -y install epel-release nfs-utils

# set root's authorized_keys: for auto backup & login
mkdir -p /root/.ssh
chmod 700 /root/.ssh
curl http://sf.snu.ac.kr/root/authorized_keys -o /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# add users
curl -sL http://sf.snu.ac.kr/root/useradd-script.sh | bash -s

# set directories
mkdir /web
mkdir /opt/devel
echo "sn01-external:/data/home  /home       nfs     rsize=8192,wsize=8192,timeo=14,intr" >> /etc/fstab
echo "sn01-external:/data/web  /web       nfs     rsize=8192,wsize=8192,timeo=14,intr" >> /etc/fstab
mount /home
mount /web

# let SELinux accept pubkeys in NFS mount
setsebool -P use_nfs_home_dirs 1
