#!/usr/bin/env bash

# Fuzzy finds music and audio tracks and adds it to cmus' play queue.

audio=$(find $HOME/Music $HOME/Audio -name *.ogg -o -name *.mp3 -o -name *.wma | fzf --multi --preview '~/.config/ranger/scope.sh {} 50 50 ~/.testing False' --preview-window=right:60 | sed -E 's/^(.*)$/"\1"/g')

cmus_id=$(pgrep cmus)

# If you cmus isn't opened yet, open it.
# This should changed to be less i3 dependant.
if [[ -z "$cmus_id" ]]; then
    $HOME/Scripts/i3/open-switch/open-switch-terminal.sh "13 " cmus
fi

# Clear the queue. Might be better to prepend to the list
cmus-remote --queue --clear

echo $audio | xargs cmus-remote -q

cmus-remote --stop
cmus-remote -C player-next
