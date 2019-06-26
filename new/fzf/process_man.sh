#!/usr/bin/env bash

man $(echo "$1" | sed -E 's/\((.*)\)/\1/g' | awk ' { print $2" "$1 } ')
