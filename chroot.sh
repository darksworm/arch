#!/bin/sh

set -e

HOSTNAME=blacktop
USERNAME=ilmars

echo We are now CHROOT!

echo Please enter a password for the root account
passwd

ln -sf /usr/share/zoneinfo/Europe/Riga /etc/localtime
hwclock --systohc

sed -i 's/#lv_LV.UTF-8 UTF-8/lv_LV.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen

echo LANG=lv_LV.UTF-8 > /etc/locale.conf
echo $HOSTNAME > /etc/hostname

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

systemctl enable dhcpcd

echo Adding user $USERNAME

adduser -m $USERNAME
passwd $USERNAME
groupadd sudo
usermod -a -G sudo $USERNAME
