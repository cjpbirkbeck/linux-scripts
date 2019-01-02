#!/usr/bin/env bash
# Describe script here.
# Created on Thursday December 06, 2018.
# Created by Christopher Birkbeck

command=$(apropos --sections 1,4,5,6,7,8 . | rofi -dmenu | awk ' { print $1 } ')

if ( ! i3-msg -t get_tree | jq '.' | grep -E "\"window_role\": \"man_${command}\"" ); then
  i3-msg "exec termite --exec=\"man ${command}\" --role=man_${command}"
else
  i3-msg "[window_role=\"man_${command}\"] focus"
fi
