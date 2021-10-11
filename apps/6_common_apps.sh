#!/bin/sh

set -e

pacman -S --noconfirm dmenu tmux openssh htop sxiv

sudo -i -u ilmars sh << EOF
yay -S --noconfirm brave-bin noto-fonts-emoji
EOF
