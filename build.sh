#!/bin/bash

if ! type "create-dmg" > /dev/null; then
  echo "!! Install create-dmg before to run this script (brew install create-dmg) !!"
  exit
fi

if [ ! -d "source_folder/Megacubo.app" ] 
then
    echo "!! Directory source_folder/Megacubo.app DOES NOT exists. You can extract Megacubo.app from the Megacubo DMG file of any version >= 17.0.0. !!" 
    exit
fi

test -f source_folder/README.md && rm source_folder/README.md
test -f Megacubo.dmg && rm Megacubo.dmg
test -f rw.Megacubo.dmg && rm rw.Megacubo.dmg
test -f rw.Megacubo.app.dmg && rm rw.Megacubo.app.dmg

rm -rf tmp

mkdir tmp



while ! git clone https://github.com/efoxbr/megacubo/ tmp/; do
    sleep 1
done

if [ $? -eq 0 ] 
then
	cp -R tmp/www/nodejs-project/. source_folder/Megacubo.app/Contents/Resources/app/
	cd source_folder/Megacubo.app/Contents/Resources/app/
	npm install
	cd ../../../../..
	test -f ffmpeg && cp ffmpeg source_folder/Megacubo.app/Contents/Resources/

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

else

	echo "Failed to clone."
	
fi