#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 24, 2018.
# Created by Christopher Birkbeck

next=$(fasd -dlR | rofi -dmenu -p "open in")
termite --directory="$next"
