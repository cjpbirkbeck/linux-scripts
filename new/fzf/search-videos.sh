#!/usr/bin/env bash

# Open any video files with fzf

videos=$(find $HOME/Videos $HOME/Downloads -name *.avi -o -name *.mkv -o -name *.mp4 -o -name *.webm | fzf-tmux --query="${1}" --prompt="Videos> " --select-1 --exit-0 --multi --preview '~/.config/ranger/scope.sh {} 50 50 ~/.testing False' --preview-window=right:60 | sed -E 's/^(.*)$/"\1"/g')

(setsid echo $videos | xargs mpv &)
