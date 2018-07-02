#!/bin/sh

# Randomizes my wallpapers. 

while true
do
  nitrogen --head=1 --random --set-centered ~/Pictures/wallpapers_1280_1024/ 2> /dev/null
  nitrogen --head=0 --random --set-centered ~/Pictures/wallpapers_1680_1050/ 2> /dev/null
sleep 600
done
