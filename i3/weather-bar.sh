#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 17, 2018.
# Created by Christopher Birkbeck

current="$(weather cyul --metric)"

temperature=$(echo "$current" | awk ' /Temperature:/ { print $2 " °" $3 } ')

if echo "$current" | grep "Weather: " ; then
  conditions=$(echo "$current" | awk ' /Weather: / { $1 = ""; print } ')
else
  conditions=$(echo "$current" | awk ' /Sky conditions: / { $1 = ""; $2 = ""; print } ')
fi

glyph=""

if [[ $conditions =~ snow ]]; then
  glyph=""
elif [[ $conditions =~ rain ]]; then
  glyph=""
elif [[ $conditions =~ sunny ]]; then
  glyph=""
elif [[ $conditions =~ cloudy ]]; then
  glyph=""
fi

conditions=$(echo "$conditions" | sed -E -e "s_\\b(.)_\\u\\1_g")

echo "$glyph $conditions $temperature"
