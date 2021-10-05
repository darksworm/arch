#!/bin/sh
set -e

# Partitions
PARTITIONS_INSTALLATION_DISK=/dev/sda
PARTITIONS_HOME_PARTITION_SIZE_MB=2048
PARTITIONS_ROOT_PARTITION_SIZE_MB=16384
PARTITIONS_EFI_PARTITION_SIZE_MB=512

echo -n "Checking network connectivity "
ping -c 1 -W 3 google.com &> /dev/null || ( echo "ERROR" && exit 1 ) && echo "OK"

timedatectl set-ntp true

# create disk partitions
sfdisk $PARTITIONS_INSTALLATION_DISK -uM << EOF
,$PARTITIONS_EFI_PARTITION_SIZE_MB
,$PARTITIONS_ROOT_PARTITION_SIZE_MB
,$PARTITIONS_HOME_PARTITION_SIZE_MB
;
EOF
