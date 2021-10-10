#!/bin/sh

set -e

CONF_DIR=/opt/arch/conf
BIN_DIR=/opt/arch/bin

# yay
pacman -S --noconfirm go
cd /opt
git clone https://aur.archlinux.org/yay-git.git
chown -R ilmars yay-git
su ilmars -c "cd /opt/yay-git && makepkg --noconfirm"
cd yay-git
pacman -U --noconfirm $(ls -1 | grep tar.zst)
cd .. && rm -rf yay-git
pacman -R --noconfirm go

yay # update

# video drivers
pacman -S --noconfirm xf86-video-intel mesa xorg-xinit
# xorg server / x11
pacman -S --noconfirm xorg-server xorg-xbacklight

mkdir -p /etc/X11/xorg.conf.d
cp $CONF_DIR/30-touchpad.conf /etc/X11/xorg.conf.d/

for USERNAME in ilmars work; do
    ln -sf $CONF_DIR/xinitrc /home/$USERNAME/.xinitrc
    ln -sf $CONF_DIR/xresources /home/$USERNAME/.Xresources
    ln -sf $CONF_DIR/xmodmap /home/$USERNAME/.Xmodmap
done

chmod +x $BIN_DIR/defaultmon
ln -sf $BIN_DIR/defaultmon /bin/defaultmon

yay -S --noconfirm xbanish nitrogen sxhkd xcape cbatticon networkmanager pa-applet-git blueman bluetooth-autoconnect xfce4-power-manager compton xautolock redshift st brave-bin

cd /opt
git clone https://github.com/darksworm/dwm
cd dwm && make install
