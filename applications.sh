#!/bin/sh

set -e

export CONF_DIR=/opt/arch/conf
export BIN_DIR=/opt/arch/bin

for SCRIPT in $(ls -1 apps); do
    chmod +x apps/$SCRIPT
    ./apps/$SCRIPT
done

chmod +x $BIN_DIR/defaultmon
ln -sf $BIN_DIR/defaultmon /bin/defaultmon

sudo -i -u ilmars sh << EOF
yay -S --noconfirm xbanish nitrogen sxhkd xcape cbatticon networkmanager pa-applet-git blueman bluetooth-autoconnect xfce4-power-manager compton xautolock redshift st brave-bin
EOF

cd /opt
git clone https://github.com/darksworm/dwm
cd dwm && make install
