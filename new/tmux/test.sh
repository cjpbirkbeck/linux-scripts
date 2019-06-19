#!/usr/bin/env bash

if [[ $TERM = "xterm-termite" ]]; then
    export TERM="xterm-256color"
fi

tmux
