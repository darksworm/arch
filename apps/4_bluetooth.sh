#!/bin/sh

set -e

sudo -i -u ilmars sh << EOF
yay -S --noconfirm bluez pulseaudio-bluetooth blueman bluetooth-autoconnect 
EOF

systemctl enable bluetooth
