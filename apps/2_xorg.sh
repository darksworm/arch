#!/bin/sh

# video drivers
pacman -S --noconfirm xf86-video-intel mesa xorg-xinit

# xorg server / x11
pacman -S --noconfirm xorg-server xorg-xbacklight xorg-xset

# x tools
pacman -S --noconfirm xbanish sxhkd xcape disper arandr xsecurelock xss-lock mpv imagemagick scrot xsecurelock

mkdir -p /etc/X11/xorg.conf.d
for FILE in $CONF_DIR/xorg/*; do
  ln -sf $FILE /etc/X11/xorg.conf.d/$(basename $FILE)
done

# basic setup for startx
for USERNAME in $GUI_USERS; do
    mkdir -p /home/$USERNAME/.config/sxhkd
    mkdir -p /home/$USERNAME/.cache/lockscreen

    ln -sf $CONF_DIR/xinitrc /home/$USERNAME/.xinitrc
    ln -sf $CONF_DIR/xresources /home/$USERNAME/.Xresources
    ln -sf $CONF_DIR/xmodmap /home/$USERNAME/.Xmodmap
    ln -sf $CONF_DIR/sxhkdrc /home/$USERNAME/.config/sxhkd/sxhkdrc
    ln -sf $CONF_DIR/screenlayouts /home/$USERNAME/.config/screenlayouts

    chown -R -h $USERNAME /home/$USERNAME/.config
done
