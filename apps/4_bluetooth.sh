#!/bin/sh

set -e

yay -S bluez pulseaudio-bluetooth blueman bluetooth-autoconnect 
systemctl enable bluetooth
