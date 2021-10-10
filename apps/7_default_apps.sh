#!/bin/sh

pacman -S --noconfirm xdg-utils

xdg-mime default brave.desktop x-scheme-handler/http
xdg-mime default brave.desktop x-scheme-handler/https    
