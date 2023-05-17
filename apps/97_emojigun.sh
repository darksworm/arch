#!/bin/sh


git clone https://github.com/darksworm/emojigun /opt/emojigun
mkdir /opt/emojigun/src/build

cd /opt/emojigun/src/build 
cmake ..

make install -j8

mkdir -p /usr/share/emojis
cd /usr/share/emojis
wget -q0- https://s3-eu-west-1.amazonaws.com/emojigun.com/top-emojis.zip | bsdtar -xvf-

chgrp -R maintainers /usr/share/emojis
chmod -R g+rw /usr/share/emojis

for USERNAME in $GUI_USERS; do
    ln -sf /usr/share/emojis ~/.emojigun
done

