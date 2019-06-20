#!/usr/bin/env bash

if [[ $TERM = "xterm-termite" ]]; then
    export TERM="xterm-256color"
fi

if tmux has-session -t Local; then
    echo "Utils session is active."
else
    tmux new-session -d -s Local -n Summary gotop

    # Remove the clock/date from the status bar.
    tmux set -t Local status-right ' #{?client_prefix,#[reverse]<Prefix>#[noreverse] ,}"#{=21:pane_title}" '

    # Stop process from renaming elements in the status bar.
    tmux set -t Local allow-rename off

    tmux new-window -a -t Local:1 -n Processes htop
fi
