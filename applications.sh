#!/bin/sh

set -e

export CONF_DIR=/opt/arch/conf
export BIN_DIR=/opt/arch/bin

for SCRIPT in $(ls -1 /opt/arch/apps); do
    echo
    echo "Running $SCRIPT"
    chmod +x /opt/arch/$SCRIPT
    ./opt/arch/$SCRIPT
done
