#!/usr/bin/env bash
# Opens programs in i3 if not already present. If they are already present, then they will set a mark.
# Created on Wednesday September 05, 2018.

prog="$1"
workspace="$2"

if ( ! i3-msg -t get_tree | jq '.' | grep -E "\"class\": \"${prog}\"" ); then
  i3-msg "workspace ${workspace}; exec termite --exec=${prog} --class=${prog}"
else
  i3-msg "[class=\"${prog}\"] focus"
fi
