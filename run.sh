#!/bin/bash

echo "This command will test live changes on source_folder/Megacubo.app/Contents/Resources folder." 

if [ ! -d "source_folder/Megacubo.app/Contents/Resources/app/node_modules" ] 
then
    echo "!! You'll need to run build.sh once before to call run.sh command to prepare files. !!" 
    exit
fi

cd source_folder/Megacubo.app/Contents/Resources/app
../../MacOS/Electron .
cd ../../../../../
