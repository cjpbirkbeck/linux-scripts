#!/usr/bin/env bash
# Opens programs in i3 if not already present. If they are already present, then they will set a mark.
# Created on Wednesday September 05, 2018.

workspace="$1"
prog="$2"

shift 2
args="$*"

if ( ! i3-msg -t get_tree | jq '.' | grep -E "\"window_role\": \"${prog}\"" ); then
  i3-msg "workspace ${workspace}; exec termite --exec=\"${prog} ${args}\" --role=${prog}"
else
  i3-msg "[window_role=\"${prog}\"] focus"
fi
