#!/usr/bin/env bash

# install packages
pacman -Syu
pacman -S --needed base-devel vi vim emacs git nfs-utils
mhwd-kernel -l # consider installing a new one

# get NFS share
mkdir /web
mkdir /opt/devel
echo "sn01-external:/data/home  /home       nfs     rsize=8192,wsize=8192,timeo=14,intr" >> /etc/fstab
echo "sn01-external:/data/web  /web       nfs     rsize=8192,wsize=8192,timeo=14,intr" >> /etc/fstab
mount /home
mount /web

# set root's authorized_keys
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cp ../authorized_keys /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# add users
./useradd-gen.py | bash -s