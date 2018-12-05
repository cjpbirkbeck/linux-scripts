#!/usr/bin/env bash
# Describe script here.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

name=$(date +%F_%T_%p)

maim -s -c 1,0,0,0.6 -p 10 "$HOME/Pictures/screenshots/${name}.png"
sxiv "$HOME/Pictures/screenshots/${name}.png"
