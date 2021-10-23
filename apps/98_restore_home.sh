#!/bin/sh

pacman -S --noconfirm rsync

for USER in $GUI_USERS do;
  sudo -i -u $USER sh << EOF
sh $BIN_DIR/restore_home \$(whoami)
EOF
done
