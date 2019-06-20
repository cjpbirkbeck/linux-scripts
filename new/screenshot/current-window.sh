#!/usr/bin/env bash
# Creates a screenshot for a single window.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

name=$(date +%F_%T_%p)

maim -u -i "$(xdotool getactivewindow)" "$HOME/Pictures/Screenshots/window/${name}.png"
sxiv "$HOME/Pictures/Screenshots/window/${name}.png"
