#!/usr/bin/env bash
# Describe script here.
# Created on Thursday December 13, 2018.
# Created by Christopher Birkbeck

if [[ $# -lt 2 ]]; then
  echo "Not enough arguments" && exit 1
fi

if [[ "$1" = "desktop" ]] || [[ "$1" == "server" ]]; then
  type="$1"
else
  echo "Type must be either \"desktop\" or \"server\"" && exit 1
fi

shift
name="$2"

if [[ "$type" = "desktop" ]]; then
  VBoxManage clonevim Linux_Desktop --name "${name}"
elif [[ "$type" = "server" ]]; then
  VBoxManage clonevim Linux_Server --name "${name}"
fi

VBoxManage registervm "$HOME/Virtual_Machines/${name}"
