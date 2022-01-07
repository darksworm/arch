#!/bin/sh

set -e

pacman -S --noconfirm openssh htop sxiv scrot gnome-keyring libsecret redshift acpi

echo password	optional	pam_gnome_keyring.so >> /etc/pam.d/passwd

yay_install brave-bin noto-fonts-emoji spotify xclip qalculate-gtk

cd /opt
rm -rf /opt/discord
wget 'https://discord.com/api/download?platform=linux&format=tar.gz' -O discord.tar.gz
tar -xvf discord.tar.gz
rm -rf discord.tar.gz
ln -sf /opt/Discord/Discord /bin/Discord
ln -sf /opt/Discord/discord.desktop /usr/share/applications/discord.desktop
sed -i 's/\/usr\/share\/discord\/Discord/\/opt\/discord\/Discord/' /opt/Discord/discord.desktop
