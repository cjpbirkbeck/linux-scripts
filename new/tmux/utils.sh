#!/usr/bin/env bash
# Creates a new "util" tmux session, if none exists

if tmux has-session -t Utils; then
    echo "Utils session is active."
    # tmux attach -t Utils
else
    tmux -f ./utils/.tmux.conf
fi
