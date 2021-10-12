#!/bin/sh

sudo -i -u work sh << EOF
yay -S --noconfirm slack-desktop rsync docker docker-compose libreoffice networkmanager-openvpn tfswitch

sudo usermod -a -g docker work
sudo usermod -a -g docker ilmars

scp -r ilmars@192.168.1.111:/storage/tank/laptop-backup/work ~/.config/backedup

rm -rf /home/work/.ssh /home/work/.aws /home/work/.config/JetBrains /home/work/dev

ln -sf /home/work/.config/backedup/ssh /home/work/.ssh
ln -sf /home/work/.config/backedup/aws /home/work/.aws

mkdir -p /home/work/.config/JetBrains/DataGrip2021.2
ln -sf /home/work/.config/backedup/datagrip /home/work/.config/JetBrains/DataGrip2021.2

mkdir ~/dev
rsync -avz --exclude 'mysql8' deploy-box:/home/ec2-user/\* ~/dev/

tfswitch --latest
EOF
