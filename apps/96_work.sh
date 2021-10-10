#!/bin/sh

sudo -i -u work sh << EOF
yay -S --noconfirm slack
scp ilmars@192.168.1.111:/storage/tank/laptop-backup/work ~/.config/backedup
rm -rf ~/.ssh ~/.aws ~/.config/JetBrains
ln -sf /home/work/.config/backedup/ssh ~/.ssh
ln -sf /home/work/.config/backedup/aws ~/.aws
mkdir -p /home/work/.config/JetBrains/DataGrip2021.2
ln -sf /home/work/.config/backedup/datagrip ~/.config/JetBrains/DataGrip2021.2

mkdir ~/dev
rsync -avz deploy-box:/home/ec2-user/* ~/dev/
EOF
