#!/bin/sh

set -e

sudo -i -u ilmars sh << EOF
yay -S --noconfirm arc-gtk-theme
EOF
