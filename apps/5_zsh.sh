#!/bin/sh

pacman -S zsh

groupadd chsh
sed -i '2s;^;auth sufficient  pam_wheel.so  trust group=chsh\n;' /etc/pam.d/chsh

for USERNAME in ilmars work; do
    usermod -a -G chsh $USERNAME
    sudo -i -u $USERNAME zsh << EOF
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
        setopt EXTENDED_GLOB
        for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
          ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
        done
        
        chsh -s /bin/zsh
    EOF
done

sed -i '2d' /etc/pam.d/chsh
groupdel chsh
