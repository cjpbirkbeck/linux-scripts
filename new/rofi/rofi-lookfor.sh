#!/usr/bin/env bash

choice="$(printf "Audio\nBooks\nImages\nManpages\nMusic\nVideo\n" | rofi -dmenu -p "Look for" -i -only-match)"

if [[ $(wmctrl -m | awk ' /Name/ { print $2 }') = "i3" ]]; then
    termite --role="look_for" --exec="$HOME/Scripts/new/fzf/lookfor2.sh $choice"
else
    termite --exec="$HOME/Scripts/new/fzf/lookfor2.sh $choice"
fi
