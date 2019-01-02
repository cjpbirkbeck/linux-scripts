#!/usr/bin/env bash
# Describe script here.
# Created on Friday December 28, 2018.
# Created by Christopher Birkbeck

. /home/cjpbirkbeck/Scripts/lf/functions.sh

function process {
    local name="$1"

    if [[ "$name" =~ ^\.(.*) ]]; then
        local new_file="${name#.}"
    else
        local new_file=".${name}"
    fi

    if name_is_free "$new_file"; then
        rename_file "$name" "$new_file"
    else
        2&> echo "File $new_file already exists." || return 1
    fi
}

for file in "$@"; do
    process "$file"
done
