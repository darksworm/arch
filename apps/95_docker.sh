#!/bin/sh

yay_install docker docker-compose

for USER in $GUI_USERS; do
  usermod -aG docker $USER
done
