#!/bin/sh

iwctl --passphrase passphrase station wlan0 connect SSID
pacman -Sy
pacman -S --noconfirm git
git clone https://github.com/darksworm/arch
