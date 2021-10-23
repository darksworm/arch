#!/bin/sh

echo Adding user "$INSTALLER_USER"
useradd -m -G sudo "$INSTALLER_USER"

groupadd maintainers

for USERNAME in $ALL_USERS; do
  usermod -a -G maintainers "$USERNAME"
done

chgrp -R maintainers /opt/arch
chmod -R g+rwx maintainers /opt/arch
