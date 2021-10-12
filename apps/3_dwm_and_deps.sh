#!/bin/sh

set -e

ln -sf $BIN_DIR/defaultmon /bin/defaultmon
chmod --reference=$(which ls) /bin/defaultmon

sudo -i -u ilmars sh << EOF
yay -S --noconfirm xbanish nitrogen sxhkd xcape cbatticon networkmanager pa-applet-git xfce4-power-manager compton xautolock redshift disper
EOF

for USERNAME in ilmars work; do
    mkdir -p /home/$USERNAME/.config/nitrogen
    ln -sf $CONF_DIR/nitrogen.cfg /home/$USERNAME/.config/nitrogen/nitrogen.cfg
    chown -R $USERNAME /home/$USERNAME/.config/nitrogen
done

cd /opt
git clone https://github.com/darksworm/dwm
cd dwm && make install

cd /opt
git clone https://github.com/darksworm/st.git
cd st && make install

groupadd maintainers

usermod -a -G maintainers ilmars
usermod -a -G maintainers work

chgrp -R maintainers /opt/dwm /opt/st /opt/arch
chmod -R g+rwx /opt/dwm /opt/st /opt/arch
