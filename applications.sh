#!/bin/sh

set -e

export CONF_DIR=/opt/arch/conf
export BIN_DIR=/opt/arch/bin

for SCRIPT in $(ls -1 apps); do
    chmod +x apps/$SCRIPT
    ./apps/$SCRIPT
done
