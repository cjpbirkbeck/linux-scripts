#!/usr/bin/env bash
# This command will look through the man pages to read.

man -k . | fzf --prompt="Man> " --select-1 --exit-0 --querry="${1}" | tr -s ' ' | sed -E 's/\((.*)\)/\1/g' | awk ' { print $2 " " $1 } ' | xargs -r man
