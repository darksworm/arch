#!/bin/sh


set -e
# 
# cd /usr/share/themes
# wget https://github.com/dracula/gtk/archive/master.zip
# unzip master.zip
# mv gtk-master dracula
# rm master.zip

cd /tmp
#git clone https://github.com/dracula/rofi rofi

#yay_install breezex-cursor-theme plymouth-themes-adi1090x-git plymouth nitrogen

# #for USERNAME in ilmars work; do
#     sudo -i -u $USERNAME zsh << EOF
# 	mkdir -p ~/.config/rofi
# 	cp /tmp/rofi/theme/config1.rasi ~/.config/rofi/config.rasi
# 
# 	gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
# 	gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
# 
# 	mkdir -p ~/.icons/default ~/.config/gtk-3.0
# 	ln -sf /opt/arch/conf/icon-index.theme ~/.icons/default/index.theme
# 	ln -sf /opt/arch/conf/gtk-settings.ini ~/.config/gtk-3.0/settings.ini
# EOF
# done
# 
# for USERNAME in $GUI_USERS; do
#     mkdir -p /home/$USERNAME/.config/nitrogen
#     ln -sf $CONF_DIR/nitrogen.cfg /home/$USERNAME/.config/nitrogen/nitrogen.cfg
#     chown -R $USERNAME /home/$USERNAME/.config/nitrogen
# done

#cd /tmp
#git clone https://github.com/dracula/grub.git dracula
#mv dracula/dracula /usr/share/grub/themes
#sed -i "s/#GRUB_THEME.*/GRUB_THEME=\/usr\/share\/grub\/themes\/dracula\/theme.txt/" /etc/default/grub
#grub-mkconfig -o /boot/grub/grub.cfg
#
#plymouth-set-default-theme -R dragon
#
# sed -i "s/HOOKS=\(base\ udev/HOOKS=\(base\ udev\ plymouth/" /etc/mkinitcpio.conf
# sed -i "s/^MODULES=.*/MODULES=\(i915\)/" /etc/mkinitcpio.conf
# sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet loglevel=0 splash rd.systemd.show_status=auto\"/" /etc/default/grub
# 
grub-mkconfig -o /boot/grub/grub.cfg

sed -i "s/echo/#echo/" /boot/grub/grub.cfg

yay_install dunst

for USERNAME in $GUI_USERS; do
    mkdir -p /home/$USERNAME/.config/dunst
    ln -sf $CONF_DIR/dunstrc /home/$USERNAME/.config/dunst/dunstrc
done
