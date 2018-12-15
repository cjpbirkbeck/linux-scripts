#!/usr/bin/env bash
# Describe script here.
# Created on Thursday December 06, 2018.
# Created by Christopher Birkbeck

while read -r line; do
  command="$(echo "${line}" | awk ' { print $1 } ')"

  echo "${command}"

  if ( ! i3-msg -t get_tree | jq '.' | grep -E "\"window_role\": \"man_${command}\"" ); then
    i3-msg "workspace 18; exec termite --exec=\"man ${command}\" --role=man_${command}"
  else
    i3-msg "[window_role=\"man_${command}\"] focus"
  fi
done < "${1:-/dev/stdin}"

