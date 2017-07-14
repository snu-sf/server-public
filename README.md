# Software Foundations Lab Server Scripts

See the [server](https://github.com/snu-sf/server) repository for more
details.

## Compute Nodes

- Install Manjaro Linux using [Manjaro Architect](https://manjaro.org/2017/03/27/install-manjaro-as-you-want-it-with-architect/).
    + Login w/ manjaro/manjaro
    + `sudo pacman-mirrors -c Japan # check if there are Korean mirrors`
    + `sudo setup`
    + language: English
    + Prepare Installation
        * Partition Disk
           - Choose Automatic Partitioning
        * Mount Partitions
           - /dev/sda2, btrfs (autodefrag, compress-force=lzo, noatime, space_cache, ssd), create subvolume, manual mode,
             mount on /, subvolume on /opt, no swap partition
           - /dev/sda1, vfat, mount on /boot # will be UEFI partition
    + Install Base
        * Install Base Packages
           - systemd, linux latest
        * Install Bootloader
           - UEFI bootloader
    + Configure Base
        * generate fstab = device UUID, hostname = cn??, locale = en_US.UTF8, timezone = Asia/Seoul, hardware clock = UTC, set root pw
    + Advanced Installations: try installing graphic card, network driver


- After reboot, you may need to set dhcp.

        systemctl enable dhcpcd@ens15f1 # `ip addr show` and check the interface name
        systemctl start dhcpcd@ens15f1
        ping www.google.com

- Run `server-public` scripts.

        cd /root
        pacman -Sy git
        git clone https://github.com/snu-sf/server-public.git
        cd server-public/cn
        ./init-manjaro.sh
        ./daily.sh

## Backup

- Install `server-public` scripts.

        cd /root
        git clone https://github.com/snu-sf/server-public.git
        crontab -e # register /root/server-public/backup/{daily,backup}.sh
