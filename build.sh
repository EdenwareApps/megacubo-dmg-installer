#!/bin/bash

if ! type "create-dmg" > /dev/null; then
  echo "!! Install create-dmg before to run this script (brew install create-dmg) !!"
  exit
fi

if [ ! -d "source_folder/Megacubo.app" ] 
then
    echo "!! Directory source_folder/Megacubo.app DOES NOT exists. You can extract Megacubo.app from the Megacubo DMG file. !!" 
    exit
fi

test -f Megacubo.dmg && rm Megacubo.dmg
test -f rw.Megacubo.dmg && rm rw.Megacubo.dmg
test -f rw.Megacubo.app.dmg && rm rw.Megacubo.app.dmg

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
