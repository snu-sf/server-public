#!/usr/bin/env bash


GID=16777216


# Detect OS
if grep -q "CentOS" /etc/os-release; then
    OS=centos
elif grep -q "Manjaro" /etc/os-release; then
    OS=manjaro
else
    echo "Cannot detect OS!"
    exit 1
fi


# Install packages
if [ $OS = "centos" ]; then
    yum -y update
    yum -y install `cat packages-centos`
elif [ $OS = "manjaro" ]; then
    pacman -Syu --noconfirm
    pacman -Sy --noconfirm --needed `cat packages-manjaro`
fi


# Add users
./adduser-gen.py $OS | bash -s


# Setup SSD
for username in `ls /home | grep "\."`; do
    uid=`stat -c '%u' /data/home/$username`
    gid=`stat -c '%g' /data/home/$username`

    if [ $gid = $GID ]; then
        mkdir -p /opt/devel/$username
        chown $uid:$gid /opt/devel/$username
    fi
done
