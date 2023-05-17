#!/bin/sh

set -e

pacman -S --noconfirm alsa-lib alsa-utils pulseaudio pulseaudio-alsa pavucontrol playerctl

for USERNAME in $GUI_USERS; do
    SYSTEMD_DIR=/home/$USERNAME/.config/systemd/user

    mkdir -p $SYSTEMD_DIR/{default.target.wants,socket.target.wants}

    # pulseaudio is started via user-bound service via systemd
    cp $CONF_DIR/systemd/user/default.target.wants/pulseaudio.service $SYSTEMD_DIR/default.target.wants
    cp $CONF_DIR/systemd/user/sockets.target.wants/pulseaudio.socket   $SYSTEMD_DIR/socket.target.wants

    chown -R $USERNAME $SYSTEMD_DIR
done
