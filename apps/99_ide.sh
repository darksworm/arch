#!/bin/sh

set -e

sudo -i -u ilmars sh << EOF
yay -S --noconfirm neovim
EOF

for USERNAME in ilmars work; do
    mkdir -p /home/$USERNAME/.config/nvim
    ln -sf $CONF_DIR/init.vim /home/$USERNAME/.config/nvim/init.vim
done

sudo -i -u ilmars sh << EOF
yay -S --noconfirm intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre datagrip datagrip-jre
EOF
