#!/bin/bash

set -e

yay_install cbatticon networkmanager pa-applet-git picom rofi nerd-fonts-hack otf-inconsolata-powerline-git rofi ttf-inconsolata ttf-symbola noto-fonts

REPOS="dwm st dmenu"

for REPO in $REPOS; do
  git clone https://github.com/darksworm/$REPO /opt/$REPO
  ( cd /opt/$REPO && make install )
  ( cd /opt/$REPO && git remote rm origin && git remote add origin git@github.com:darksworm/$REPO.git )

  chgrp -R maintainers /opt/$REPO
  chmod -R g+rwx /opt/$REPO
done
