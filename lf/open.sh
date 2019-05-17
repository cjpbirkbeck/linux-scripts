#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 24, 2018.
# Created by Christopher Birkbeck

export XDG_CURRENT_DESKTOP=kde

ZZ

if [[ "$1" = "view" ]] || [[ "$1" = "edit" ]]; then
    echo "mode is $1"
    mode="$1"
    shift
else
    exit 1
fi

for file in "$@"; do
    if ! test  -f "$file"; then echo "$file is not a file" continue; fi

    mime="$(file --brief --mime-type "$file")"
    wild="${mime/\/*/\/\*}"

    awk -v mime="$mime" -v mode="$mode" -v wild="$wild" -F'\" *\"' ' BEGIN { if (mode == "view") n = 2; else if (mode == "edit") n = 3 } { if ($1 == mime) print $n } { if ($1 == wild) print $n } '  mime-types

done
