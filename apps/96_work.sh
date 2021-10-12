#!/bin/sh

sudo -i -u work sh << EOF
yay -S --noconfirm slack-desktop rsync docker docker-compose libreoffice networkmanager-openvpn tfswitch stretchly
sh $BIN_DIR/work_restore
tfswitch --latest
EOF

usermod -aG docker work
usermod -aG docker ilmars
