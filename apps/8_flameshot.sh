#!/bin/sh

yay_install flameshot

for USER in $GUI_USERS; do
  mkdir -p ~/.config/flameshot
  ln -sf $CONF_DIR/flameshot.ini ~/.config/flameshot/flameshot.ini
done