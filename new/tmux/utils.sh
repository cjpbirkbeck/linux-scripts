#!/usr/bin/env bash
# Creates a new "util" tmux session, if none exists

tmux has-session -t utils

if [[ $? != 0 ]]; then
    tmux -f utils.conf attach
fi
