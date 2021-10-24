#!/bin/sh

pacman -S --noconfirm fzf tmux

for USER in $GUI_USERS; do
     ln -sf $CONF_DIR/tmux.conf /home/$USER/.tmux.conf
     PLUGIN_DIR=/home/$USER/.config/tmux/plugins
     mkdir -p $PLUGIN_DIR
     git clone https://github.com/tmux-plugins/tpm $PLUGIN_DIR/tpm
done

# users will have to open tmux and do [Prefix + I] to install the other plugins
