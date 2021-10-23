#!/bin/sh

set -e

. /opt/arch/.config

for SCRIPT in /opt/arch/apps/*; do
    echo
    echo "Running $SCRIPT"
    chmod +x "/opt/arch/apps/${SCRIPT}"
    sh "/opt/arch/apps/${SCRIPT}" || echo "FAILED ${SCRIPT}"
done
