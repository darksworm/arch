#!/bin/sh
set -e

# Partitions
PARTITIONS_INSTALL_DEV=/dev/nvme0n1
PARTITIONS_HOME_PARTITION_SIZE_MiB=426431
PARTITIONS_ROOT_PARTITION_SIZE_MiB=61440
PARTITIONS_EFI_PARTITION_SIZE_MiB=512

echo -n "Checking network connectivity -> "
ping -c 1 -W 3 google.com &> /dev/null || ( echo "ERROR" && exit 1 ) && echo "OK"

timedatectl set-ntp true

EFI_PARTITION_END=$PARTITIONS_EFI_PARTITION_SIZE_MiB
ROOT_PARTITION_END=$(expr $EFI_PARTITION_END + $PARTITIONS_ROOT_PARTITION_SIZE_MiB)
HOME_PARTITION_END=$(expr $ROOT_PARTITION_END + $PARTITIONS_HOME_PARTITION_SIZE_MiB)

# create disk partitions
parted --script $PARTITIONS_INSTALL_DEV \
    mklabel gpt \
    mkpart primary fat32    1MiB                       ${EFI_PARTITION_END}MiB  \
    mkpart primary ext4     ${EFI_PARTITION_END}MiB    ${ROOT_PARTITION_END}MiB \
    mkpart primary ext4     ${ROOT_PARTITION_END}MiB   ${HOME_PARTITION_END}MiB \
    set 1 esp on

PARTITIONS_EFI_DEV=${PARTITIONS_INSTALL_DEV}p1
PARTITIONS_ROOT_DEV=${PARTITIONS_INSTALL_DEV}p2
PARTITIONS_HOME_DEV=${PARTITIONS_INSTALL_DEV}p3

echo "Setting up LUKS for home partition"
cryptsetup luksFormat ${PARTITIONS_HOME_DEV}
cryptsetup open ${PARTITIONS_HOME_DEV} home

mkfs.ext4 /dev/mapper/home
mkfs.ext4 ${PARTITIONS_ROOT_DEV}
mkfs.vfat ${PARTITIONS_EFI_DEV}

echo "Partition setup complete."

mount ${PARTITIONS_ROOT_DEV} /mnt
mkdir /mnt/boot
mount ${PARTITIONS_EFI_DEV}  /mnt/boot

pacstrap /mnt base linux linux-firmware
HOME_UUID=$(blkid | grep ${PARTITIONS_HOME_DEV} | cut -d | sed 's/.*PARTUUID=//' | cut -d\" -f2)
echo home   UUID=${HOME_UUID} >> /mnt/etc/crypttab

genfstab -U /mnt >> /mnt/etc/fstab
echo /dev/mapper/home   /home   ext4    defaults    0 1 >> /mnt/etc/fstab

cp chroot.sh /mnt
arch-chroot /mnt ./chroot.sh

rm /mnt/chroot.sh
umount /mnt/boot
umount /mnt

