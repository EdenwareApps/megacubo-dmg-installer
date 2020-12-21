#!/bin/bash

if ! type "create-dmg" > /dev/null; then
  echo "!! Install create-dmg before to run this script (brew install create-dmg) !!"
  exit
fi

if [ ! -d "source_folder/Megacubo.app" ] 
then
    echo "!! Directory source_folder/Megacubo.app DOES NOT exists. You can extract Megacubo.app from the Megacubo DMG file of any version >= 16.0.0. !!" 
    exit
fi

if [ ! -f "ffmpeg" ] 
then
    echo "!! Binary executable ffmpeg DOES NOT exists in current folder. !!" 
    exit
fi

test -f source_folder/README.md && rm source_folder/README.md
test -f Megacubo.dmg && rm Megacubo.dmg
test -f rw.Megacubo.dmg && rm rw.Megacubo.dmg
test -f rw.Megacubo.app.dmg && rm rw.Megacubo.app.dmg

rm -rf source_folder/Megacubo.app/Contents/Resources/app.nw/*
rm -rf tmp

mkdir tmp
git clone https://github.com/efoxbr/megacubo/ tmp/
cp -R tmp/www/nodejs-project/. source_folder/Megacubo.app/Contents/Resources/app.nw/
mkdir source_folder/Megacubo.app/Contents/Resources/app.nw/ffmpeg
cp ffmpeg source_folder/Megacubo.app/Contents/Resources/app.nw/ffmpeg/
cp -R node_modules source_folder/Megacubo.app/Contents/Resources/app.nw/

create-dmg \
 --volname "Megacubo" \
 --volicon "source_folder/Megacubo.app/Contents/Resources/app.icns" \
 --window-size 640 384 \
 --text-size 16 \
 --icon-size 128 \
 --app-drop-link 466 160 \
 --icon "Megacubo.app" 160 160 \
 --hide-extension "Megacubo.app" \
 "Megacubo.dmg" \
 "source_folder/"
