#!/bin/sh

sudo -i -u work sh << EOF
yay -S --noconfirm slack rsync

scp ilmars@192.168.1.111:/storage/tank/laptop-backup/work ~/.config/backedup

rm -rf /home/work/.ssh /home/work/.aws /home/work/.config/JetBrains /home/work/dev

ln -sf /home/work/.config/backedup/ssh /home/work/.ssh
ln -sf /home/work/.config/backedup/aws /home/work/.aws

mkdir -p /home/work/.config/JetBrains/DataGrip2021.2
ln -sf /home/work/.config/backedup/datagrip /home/work/.config/JetBrains/DataGrip2021.2

mkdir ~/dev
rsync -avz deploy-box:/home/ec2-user/\* ~/dev/
EOF
