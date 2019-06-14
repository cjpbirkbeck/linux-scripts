#!/usr/bin/env bash
# Using fasd and fzf.

fasd "$@" | fzf --no-sort --multi --select-1 --exit-0 | awk ' { print $2 } '
