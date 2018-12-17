#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 17, 2018.
# Created by Christopher Birkbeck

cal --color=always | sed 's/\x1b\[[7;]*m/\<b\>\<u\>/g' | sed 's/\x1b\[[27;]*m/\<\/u\>\<\/b\>/g' | rofi -dmenu -no-config -markup-rows -no-fullscreen -font "DejaVu Sans Mono 12" -hide-scrollbar -bw 2 -m -3 -theme-str '#monitor {anchor: northwest; location: northeast;}' -eh 1 -width -22 -p "" > /dev/null
