#!/bin/sh
set -e

# Partitions
PARTITIONS_INSTALLATION_DISK=/dev/sda
PARTITIONS_HOME_PARTITION_SIZE_MB=2048
PARTITIONS_ROOT_PARTITION_SIZE_MB=16384
PARTITIONS_EFI_PARTITION_SIZE_MB=512

ping google.com || ( echo google is not reachable! && exit 1 )

timedatectl set-ntp true


