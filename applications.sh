#!/bin/sh

CONF_DIR=/opt/arch/conf

# video drivers
pacman -S --noconfirm xf86-video-intel mesa
# xorg server / x11
pacman -S --noconfirm xorg-server xorg-xbacklight

mkdir -p /etc/X11/xorg.conf.d
cp $CONF_DIR/30-touchpad.conf /etc/X11/xorg.conf.d/

