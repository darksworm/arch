#!/bin/sh

set -e

cd /usr/share/themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master dracula
rm master.zip

cd /tmp
git clone https://github.com/dracula/rofi

sudo -i -u ilmars zsh << EOF
yay -S --noconfirm breezex-cursor-theme
EOF

for USERNAME in ilmars work; do
    sudo -i -u $USERNAME zsh << EOF
	mkdir -p ~/.config/rofi
	cp /tmp/rofi/theme/config1.rasi ~/.config/rofi/config.rasi

	gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
	gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

	mkdir -p ~/.icons/default ~/.config/gtk-3.0
	ln -sf /opt/arch/conf/icon-index.theme ~/.icons/default/index.theme
	ln -sf /opt/arch/conf/gtk-settings.ini ~/.config/gtk-3.0/settings.ini
EOF
done

