#!/usr/bin/env python3

import os
import sys

GID=16777216

if __name__ == "__main__":
    os_kind = sys.argv[0]

    print("#!/usr/bin/env bash")
    print("groupadd -g {} members".format(GID))
    print()

    for username in os.listdir("/home"):
        names = username.split(".")
        if len(names) != 2:
            continue
        firstname = names[0]
        lastname = names[1]

        stat = os.stat('/home/{}'.format(username))
        uid = stat.st_uid
        gid = stat.st_gid
        if gid != GID:
            continue

        if os_kind == "centos":
            print("useradd -M -d /home/{}.{} --group members -u {} {}.{}".format(firstname, lastname, uid, firstname, lastname))
        elif os_kind == "manjaro":
            print("useradd -M -d /home/{}.{} --group members -u {} {}_{}".format(firstname, lastname, uid, firstname, lastname))
            print("sed -i -e 's:{}_{}:{}.{}:g' /etc/passwd".format(firstname, lastname, firstname, lastname))
            print("sed -i -e 's:{}_{}:{}.{}:g' /etc/group".format(firstname, lastname, firstname, lastname))
            print("sed -i -e 's:{}_{}:{}.{}:g' /etc/shadow".format(firstname, lastname, firstname, lastname))
            print("sed -i -e 's:{}_{}:{}.{}:g' /etc/gshadow".format(firstname, lastname, firstname, lastname))
        else:
            raise Exception("Unknown OS {}".format(os_kind))
        print()
