#!/usr/bin/env bash

session="$(tmux list-sessions | rofi -dmenu | awk ' !/\(attached\)/ { print substr($1,0,length($1)-1) } ')"

termite --title="TMUX {$session}" --command="tmux attach-session -t $session"


