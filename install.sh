#!/bin/sh
set -e

# Partitions
PARTITIONS_INSTALL_DEV=/dev/sda
PARTITIONS_HOME_PARTITION_SIZE_MiB=4096
PARTITIONS_ROOT_PARTITION_SIZE_MiB=16384
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

PARTITIONS_EFI_DEV=${PARTITIONS_INSTALL_DEV}1
PARTITIONS_ROOT_DEV=${PARTITIONS_INSTALL_DEV}2
PARTITIONS_HOME_DEV=${PARTITIONS_INSTALL_DEV}3

echo "Setting up LUKS for home partition"
cryptsetup luksFormat ${PARTITIONS_HOME_DEV}
cryptsetup open ${PARTITIONS_HOME_DEV} home

mkfs.ext4 /dev/mapper/home
mkfs.ext4 ${PARTITIONS_ROOT_DEV}

echo "Partition setup complete."

mount ${PARTITIONS_ROOT_DEV} /mnt

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

cp chroot.sh /mnt
arch-chroot /mnt ./chroot.sh
