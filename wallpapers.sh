#!/bin/sh

# Randomizes my wallpapers. 

while true
do 
  nitrogen --head=1 --random --set-centered ~/Pictures/wallpapers_1280_1024/ 
  nitrogen --head=0 --random --set-centered ~/Pictures/wallpapers_1680_1050/
sleep 600
done
