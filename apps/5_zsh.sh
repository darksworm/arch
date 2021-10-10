#!/bin/sh

set -e

pacman -S --noconfirm zsh

for USERNAME in ilmars work; do
    sudo -i -u $USERNAME zsh << EOF
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "\${ZDOTDIR:-\$HOME}/.zprezto"
        
        setopt EXTENDED_GLOB
        
        for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
          ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
        done
EOF
    chsh -s $(which zsh) $USERNAME
done
