#!/bin/sh

# video drivers
pacman -S --noconfirm xf86-video-intel mesa xorg-xinit
# xorg server / x11
pacman -S --noconfirm xorg-server xorg-xbacklight

mkdir -p /etc/X11/xorg.conf.d
cp $CONF_DIR/30-touchpad.conf /etc/X11/xorg.conf.d/

# basic setup for startx
for USERNAME in ilmars work; do
    mkdir -p /home/$USERNAME/.config/sxhkd
    ln -sf $CONF_DIR/xinitrc /home/$USERNAME/.xinitrc
    ln -sf $CONF_DIR/xresources /home/$USERNAME/.Xresources
    ln -sf $CONF_DIR/xmodmap /home/$USERNAME/.Xmodmap
    ls -sf $CONF_DIR/sxhkd /home/$USERNAME/.config/sxhkd/sxhkdrc
done
