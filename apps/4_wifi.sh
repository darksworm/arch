#!/bin/sh

set -e

pacman -S --noconfirm network-manager-applet
systemctl enable NetworkManager
