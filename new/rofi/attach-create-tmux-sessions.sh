#!/usr/bin/env bash

tmux list-session | awk ' { print substr($1,0,length($1)-1) } ' | xargs --null tmux attach-sesion -t
