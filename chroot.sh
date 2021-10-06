#!/bin/sh

HOSTNAME=blacktop

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

mkinitcpio -P
