#!/bin/sh

set -e

pacman -S --noconfirm dmenu tmux

sudo -i -u ilmars sh << EOF
yay -S --noconfirm brave-bin
EOF
