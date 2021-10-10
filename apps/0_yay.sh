#!/bin/sh

set -e

pacman -S --noconfirm go
cd /opt
git clone https://aur.archlinux.org/yay-git.git
chown -R ilmars yay-git
su ilmars -c "cd /opt/yay-git && makepkg --noconfirm"
cd yay-git
pacman -U --noconfirm $(ls -1 | grep tar.zst)
cd .. && rm -rf yay-git
pacman -R --noconfirm go
