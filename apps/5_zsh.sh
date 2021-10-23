#!/bin/sh

set -e

pacman -S --noconfirm zsh

for USERNAME in $GUI_USERS; do
    sudo -i -u $USERNAME zsh << EOF
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "\${ZDOTDIR:-\$HOME}/.zprezto"
        
        setopt EXTENDED_GLOB
        
        for rcfile in "\${ZDOTDIR:-\$HOME}"/.zprezto/runcoms/^README.md(.N); do
          ln -sf "\$rcfile" "\${ZDOTDIR:-\$HOME}/.\${rcfile:t}"
        done

	( cat ~/.zshrc | grep defaultrc ) || echo source /opt/arch/conf/defaultrc >> ~./zshrc
	( cat ~/.zshrc | grep ${USERNAME}rc ) || echo source /opt/arch/conf/${USERNAME}rc  >> ~./zshrc
EOF
    chsh -s $(which zsh) $USERNAME
done
