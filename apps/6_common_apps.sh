#!/bin/sh

set -e

pacman -S --noconfirm dmenu tmux openssh htop sxiv scrot gnome-keyring libsecret

echo password	optional	pam_gnome_keyring.so >> /etc/pam.d/passwd

sudo -i -u ilmars sh << EOF
yay -S --noconfirm brave-bin noto-fonts-emoji spotify xclip
EOF

cd /opt
wget 'https://discord.com/api/download?platform=linux&format=tar.gz' -O dank.tar.gz
tar -xvf dank.tar.gz
rm -rf dank.tar.gz
ln -sf /bin/discord /opt/Discord/Discord
