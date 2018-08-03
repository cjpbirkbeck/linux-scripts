#!/bin/sh

# Randomizes my wallpapers. 

nature=true

while true
do
  if ( $nature ); then
    nitrogen --head=0 --random --set-centered ~/Pictures/wallpapers_1680_1050/nature/ 2> /dev/null
    nature=false
  else
    nitrogen --head=0 --random --set-centered ~/Pictures/wallpapers_1680_1050/cityscapes/ 2> /dev/null
    nature=true
  fi
  nitrogen --head=1 --random --set-centered ~/Pictures/wallpapers_1280_1024/ 2> /dev/null
sleep 600
done
