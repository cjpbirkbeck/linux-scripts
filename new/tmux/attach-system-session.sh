#!/usr/bin/env bash

if tmux has-session -t System; then
    termite --exec='tmux attach-session -t System'
else
    tmux new-session -t System
fi
