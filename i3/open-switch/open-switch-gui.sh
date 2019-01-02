#!/usr/bin/env bash
# Describe script here.
# Created on Tuesday December 11, 2018.
# Created by Christopher Birkbeck

de="$1"
workspace="$2"
prog="$3"

mark="___${prog}"

shift 3

args="$*"

if ( ! i3-msg -t get_marks | jq '.[]' | grep "${mark}" ); then
  i3-msg "workspace ${workspace}; exec ${de} ${prog} ${args}; mark ${mark}"
else
  i3-msg "[con_mark=\"${mark}\"] focus"
fi
