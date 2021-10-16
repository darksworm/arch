#!/bin/sh

set -e

pacman -S --noconfirm alsa pulseaudio pulseaudio-alsa pavucontrol playerctl

for USERNAME in ilmars work; do
    mkdir -p /home/$USERNAME/.config
    cp $CONF_DIR/systemd /home/$USERNAME/.config/
    chown -R $USERNAME /home/$USERNAME/.config/systemd
done
