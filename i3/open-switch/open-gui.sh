#!/usr/bin/env bash
# Opens programs in i3 if not already present. If they are already present, then they will set a mark.
# Created on Wednesday September 05, 2018.

de="$1"
workspace="$2"
prog="$3"

echo "$de"
echo "$workspace"
echo "$prog"

shift 3

args="$*"

echo "$args"

if ( ! i3-msg -t get_tree | jq '.' | grep -E -i "\"class\": \"$prog\"" ); then
  i3-msg "workspace ${workspace}; exec ${de} ${prog} ${args}"
else
  i3-msg "[class=\"$prog\"] focus"
fi
