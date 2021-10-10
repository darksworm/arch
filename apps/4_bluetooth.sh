#!/bin/sh

set -e

pacman -S bluez pulseaudio-bluetooth blueman bluetooth-autoconnect 
systemctl enable bluetooth
