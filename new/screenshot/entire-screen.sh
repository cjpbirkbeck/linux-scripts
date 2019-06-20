#!/usr/bin/env bash
# Takes a screenshot of the entire screen.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

name=$(date +%F_%T_%p)

maim "$HOME/Pictures/Screenshots/full/${name}.png"
sxiv "$HOME/Pictures/Screenshots/full/${name}.png"
