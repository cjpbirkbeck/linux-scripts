#!/usr/bin/env bash
# Describe script here.
# Created on Friday December 28, 2018.
# Created by Christopher Birkbeck

. /home/cjpbirkbeck/Scripts/lf/functions.sh

filetype="$1"

read -r -p "Enter new filename: " -e name

if name_is_free "$name" && name_no_initial_dash "$name"; then
    if [[ "$filetype" = "text" ]]; then
        touch "$name"
    elif [[ "$filetype" = "dir" ]]; then
        mkdir "$name"
    else
        mkfile "$filetype" "$name"
    fi
else
    2&> echo "File $name already exists or is invalid."
fi
