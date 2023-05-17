#!/bin/sh

set -e

# yay needs go to compile
pacman -S --noconfirm go

git clone https://aur.archlinux.org/yay-git.git /opt/yay
chown -R "$INSTALLER_USER" /opt/yay
chmod -R 777 /opt/yay

su "$INSTALLER_USER" -c "cd /opt/yay && makepkg --noconfirm"

pacman -U --noconfirm /opt/yay/*.tar.zst

rm -rf /opt/yay
