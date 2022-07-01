#!/bin/sh

set -e

. /.config

echo Going to create users $GUI_USERS

echo We are now CHROOT!

echo Please enter a password for the root account
passwd

groupadd sudo

[ -z "$GUI_USERS" ] && ( echo "please define GUI_USERS variable" && exit 1 )

for USERNAME in $GUI_USERS; do
    echo Adding user "$USERNAME"
    useradd -m -G sudo "$USERNAME"
    passwd "$USERNAME"
done

ln -sf /usr/share/zoneinfo/Europe/Riga /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF/en_US.UTF/g' /etc/locale.gen
sed -i 's/#lv_LV.UTF/lv_LV.UTF/g' /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8		>  /etc/locale.conf
echo LC_ALL=en_US.UTF-8		>> /etc/locale.conf

[ -z "$HOSTNAME" ] && ( echo "please define HOSTNAME variable" && exit 1 )

echo "$HOSTNAME" > /etc/hostname

echo "127.0.0.1     localhost" >    /etc/hosts
echo "::1           localhost" >>   /etc/hosts
echo "127.0.1.1     $HOSTNAME" >>   /etc/hosts

# hooks for decrypting LUKS partition
HOOKS_BASE=$(cat /etc/mkinitcpio.conf | grep -v "#" | grep HOOKS)
HOOKS_OPEN=$(echo $HOOKS_BASE | sed 's/.$//')
HOOKS_NEW="$HOOKS_OPEN systemd sd-encrypt sd-lvm2)"
sed -i "s/${HOOKS_BASE}/${HOOKS_NEW}/" /etc/mkinitcpio.conf

mkinitcpio -P

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sed -i 's/\ quiet//g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo KEYMAP=lv > /etc/vconsole.conf

systemctl enable dhcpcd

sed -i '/^root.*/i %sudo ALL=(ALL:ALL) ALL' /etc/sudoers

mkdir -p /opt
cd /opt && git clone https://github.com/darksworm/arch

cd /opt/arch
git remote rm origin
git remote add origin git@github.com:darksworm/arch.git

chmod +x /opt/arch/applications.sh
sh /opt/arch/applications.sh
