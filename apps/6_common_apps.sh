#!/bin/sh

set -e

pacman -S --noconfirm tmux openssh htop sxiv scrot gnome-keyring libsecret redshift

echo password	optional	pam_gnome_keyring.so >> /etc/pam.d/passwd

yay_install brave-bin noto-fonts-emoji spotify xclip

cd /opt
wget 'https://discord.com/api/download?platform=linux&format=tar.gz' -O dank.tar.gz
tar -xvf dank.tar.gz
rm -rf dank.tar.gz
ln -sf /bin/discord /opt/Discord/Discord

for APP in defaultmon lock; do
  ln -sf "$BIN_DIR"/$APP /bin/$APP
  chmod --reference=/bin/ls /bin/$APP
done
