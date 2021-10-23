#!/bin/sh

set -e

pacman -S --noconfirm tmux openssh htop sxiv scrot gnome-keyring libsecret redshift

echo password	optional	pam_gnome_keyring.so >> /etc/pam.d/passwd

sudo -i -u ilmars sh << EOF
yay -S --noconfirm brave-bin noto-fonts-emoji spotify xclip
EOF

cd /opt
wget 'https://discord.com/api/download?platform=linux&format=tar.gz' -O dank.tar.gz
tar -xvf dank.tar.gz
rm -rf dank.tar.gz
ln -sf /bin/discord /opt/Discord/Discord

ln -sf $BIN_DIR/defaultmon /bin/defaultmon
chmod --reference=$(which ls) /bin/defaultmon
