#!/usr/bin/env bash
# Describe script here.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

name=$(date +%F_%T_%p)

maim -i "$(xdotool getactivewindow)" "$HOME/Pictures/screenshots/${name}.png"
sxiv "$HOME/Pictures/screenshots/${name}.png"
