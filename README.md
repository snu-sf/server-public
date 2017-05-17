# Software Foundations Lab Server Scripts

See the [server](https://github.com/snu-sf/server) repository for more
details.

## Compute Nodes

- Install Manjaro Linux using [Manjaro Architect](https://manjaro.org/2017/03/27/install-manjaro-as-you-want-it-with-architect/).
    + Login w/ manjaro/manjaro
    + `sudo pacman-mirrors -c Japan # check if there are Korean mirrors`
    + `sudo setup`
    + language: English
    + Partition Disk
        * Automatic Partitioning
        * Mount Partitions: /dev/sda2, btrfs (compress-force=lzo, autodefrag, noatime, ssd, space_cache), mount on /, subvolume on /opt, no swap
        * Mount Partitions: /dev/sda1, vfat, mount on /boot # will be UEFI partition
    + Install base packages: systemd, linux latest, UEFI bootloader
    + configure base: generate fstab = device UUID, hostname = cn??, locale = en_US.UTF8, timezone = Asia/Seoul, hardware clock = UTC, set root pw
    + advanced installtions: try installing graphic card, network driver


- After reboot, you may need to set dhcp.

        systemctl enable dhcpcd@ens15f1 # `ip addr show` and check the interface name
        systemctl start dhcpcd@ens15f1

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
