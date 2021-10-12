#!/bin/sh

set -e

pacman -S --noconfirm alsa pulseaudio pulseaudio-alsa pavucontrol

#for USERNAME in ilmars work; do
#    sudo -i -u $USERNAME sh <<EOF
#systemctl --user enable pulseaudio
#EOF
#done
