#!/bin/sh

# For both of my monitors, this will switch between naturescapes and cityscapes.
# When one screen has one, the other will show another.

nature=true

while true
do
  if ( $nature ); then
    nitrogen --head=0 --random --set-centered ~/Pictures/Wallpapers/1280_1024/naturescapes/ 2> /dev/null
    nitrogen --head=1 --random --set-centered ~/Pictures/Wallpapers/1280_1024/cityscapes/ 2> /dev/null
    nature=false
  else
    nitrogen --head=0 --random --set-centered ~/Pictures/Wallpapers/1280_1024/cityscapes/ 2> /dev/null
    nitrogen --head=1 --random --set-centered ~/Pictures/Wallpapers/1280_1024/naturescapes/ 2> /dev/null
    nature=true
  fi
sleep 600
done
