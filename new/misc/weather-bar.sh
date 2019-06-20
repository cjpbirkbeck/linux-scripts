#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 17, 2018.
# Created by Christopher Birkbeck

glyph=""
current="$(weather cyul --metric 2> /dev/null)"

if (( $? != 0 )); then echo "$glyph No connection"; exit 1; fi

temperature=$(echo "$current" | awk ' /Temperature:/ { print $2 " °" $3 } ')

if (echo "$current" | grep "Weather: ") > /dev/null ; then
  conditions=$(echo "$current" | awk ' /Weather: / { $1 = ""; print } ')
else
  conditions=$(echo "$current" | awk ' /Sky conditions: / { $1 = ""; $2 = ""; print } ')
fi

if [[ $conditions =~ snow ]]; then
  glyph=""
elif [[ $conditions =~ rain ]]; then
  glyph=""
elif [[ $conditions =~ sunny ]] || [[ $conditions =~ clear ]]; then
  glyph=""
elif [[ $conditions =~ cloudy ]] || [[ $conditions =~ overcast ]] \
  || [[ $conditions =~ mist ]]; then
  glyph=""
fi

conditions=$(echo "$conditions" | sed -E -e "s_\\b(.)_\\u\\1_g")

echo "$glyph $conditions $temperature"
