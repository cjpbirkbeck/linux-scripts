#!/usr/bin/env bash
# Describe script here.
# Created on Friday December 28, 2018.
# Created by Christopher Birkbeck

. /home/cjpbirkbeck/Scripts/lf/functions.sh

function rename_prompt {
    local old_file="$1"
    local prompt="$2"

    read -r -e -i "$old_file" -p "$prompt" new_file

    if rename_file "$old_file" "$new_file"; then
        return 0
    else
        >&2 echo "File $new_file already exists." && return 1
    fi
}

if [[ $# -eq 1 ]]; then
    rename_prompt "$1" "Enter new file name: "
else
    total=$#
    current=1

    for file in "$@"; do
        rename_prompt "$file" "Enter new file name (${current} of $total): "

        ((current++))
    done
fi
