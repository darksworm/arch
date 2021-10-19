#!/bin/sh

set -e

cd /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master dracula
rm master.zip

cd /tmp
git clone https://github.com/dracula/rofi

for USERNAME in ilmars work; do
    sudo -i -u $USERNAME zsh << EOF
	mkdir -p ~/.config/rofi
	cp /tmp/rofi/theme/config1.rasi ~/.config/rofi/config.rasi
EOF
done
