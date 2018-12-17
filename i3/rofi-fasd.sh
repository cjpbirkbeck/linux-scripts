#!/usr/bin/env bash
# Describe script here.
# Created on Sunday December 16, 2018.
# Created by Christopher Birkbeck

answer=$(fasd "$1" | rofi -dmenu)
xdotool type "${answer}" && xdotool key Return
