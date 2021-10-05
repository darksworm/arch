#!/bin/sh
set -e

# Partitions
PARTITIONS_INSTALLATION_DEVICE=/dev/sda
PARTITIONS_HOME_PARTITION_SIZE_MiB=4096
PARTITIONS_ROOT_PARTITION_SIZE_MiB=16384
PARTITIONS_EFI_PARTITION_SIZE_MiB=512

echo -n "Checking network connectivity -> "
ping -c 1 -W 3 google.com &> /dev/null || ( echo "ERROR" && exit 1 ) && echo "OK"

timedatectl set-ntp true

FIRST_PARTITION_END=$PARTITIONS_EFI_PARTITION_SIZE_MiB
SECOND_PARTITION_END=$(expr $PARTITIONS_EFI_PARTITION_SIZE_MiB + $PARTITIONS_ROOT_PARTITION_SIZE_MiB)
THRID_PARTITION_END=$(expr $SECOND_PARTITION_END + $PARTITIONS_HOME_PARTITION_SIZE_MiB)

# create disk partitions
parted --script $PARTITIONS_INSTALLATION_DEVICE \
    mklabel gpt \
    mkpart primary 1MiB ${FIRST_PARTITION_END}MiB \
    mkpart primary ${FIRST_PARTITION_END}MiB ${SECOND_PARTITION_END}MiB \
    mkpart primary ${SECOND_PARTITION_END}MiB ${THRID_PARTITION_END}MiB
