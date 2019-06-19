#!/usr/bin/env bash

if [[ $TERM = "xterm-termite" ]]; then
    export TERM="xterm-256color"
fi

if tmux has-session -t Remote; then
    echo "Utils session is active."
else
    tmux new-session -d -s Remote -n Email neomutt

    # Remove the clock/date from the status bar.
    tmux set -t Remote status-right ' #{?client_prefix,#[reverse]<Prefix>#[noreverse] ,}"#{=21:pane_title}" '

    # Stop process from renaming elements in the status bar.
    tmux set -t Remote allow-rename off

    tmux new-window -a -t Remote:1 -n Chat weechat
    tmux new-window -a -t Remote:2 -n Newsfeeds newsboat
    tmux new-window -a -t Remote:3 -n Reddit rtv
    tmux new-window -a -t Remote:4 -n YouTube youtube-viewer
fi
