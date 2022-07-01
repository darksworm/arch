#!/bin/bash

set -e

. /opt/arch/.config

for SCRIPT in /opt/arch/apps/*; do
    echo
    echo "Running $SCRIPT"
    chmod +x "${SCRIPT}"
    sh "${SCRIPT}" || echo "FAILED ${SCRIPT}"
done
