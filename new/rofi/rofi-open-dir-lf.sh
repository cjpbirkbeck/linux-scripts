#!/usr/bin/env bash

next=$(fasd -dlR | rofi -dmenu -i -only-match -p "Dir")
termite --directory="$next" --exec="lf"
