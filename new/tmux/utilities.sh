#!/usr/bin/env bash
# Creates a new "util" tmux session, if none exists

if [[ $TERM = "xterm-termite" ]]; then
    export TERM="xterm-256color"
fi

if tmux has-session -t Utils; then
    echo "Utils session is active."
else
    tmux -f ./utils/.tmux.conf
fi
