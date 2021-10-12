#!/bin/sh

set -e

pacman -S --noconfirm dmenu tmux openssh htop sxiv scrot playerctl gnome-keyring libsecret

echo password	optional	pam_gnome_keyring.so >> /etc/pam.d/passwd

sudo -i -u ilmars sh << EOF
yay -S --noconfirm brave-bin noto-fonts-emoji spotify
EOF
