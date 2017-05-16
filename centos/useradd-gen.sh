#!/usr/bin/env bash

GID=16777216

echo "#!/usr/bin/env bash"
echo "groupadd -g $GID members"

for username in `ls /home | grep "\."`; do
  uid=`stat -c '%u' /home/$username`
  gid=`stat -c '%g' /home/$username`

  if [ $gid = $GID ]; then
    echo "useradd -M -d /home/$first.$last --group members -u $uid $username"
  fi
done
