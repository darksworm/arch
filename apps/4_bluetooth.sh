#!/bin/sh

set -e

yay_install bluez pulseaudio-bluetooth blueman bluetooth-autoconnect

systemctl enable bluetooth
sed -i 's/.*utoEnabl.*/AutoEnable=true/g' /etc/bluetooth/main.conf
