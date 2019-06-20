#!/usr/bin/env bash

if [ -f $HOME/.notice_history ]; then
    awk --field-separator '	' ' { system("sh convert-unix-time.sh" $1)} { print $1' '$2' '$3 }'
else
    echo "No history file exists."
fi
