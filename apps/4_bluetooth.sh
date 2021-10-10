#!/bin/sh

set -e

yay -S --noconfirmbluez pulseaudio-bluetooth blueman bluetooth-autoconnect 
systemctl enable bluetooth
