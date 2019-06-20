#!/usr/bin/env bash
# Automatically search directories for text files.

text=$(find $HOME/Documents/Journals $HOME/Documents/Lists $HOME/Documents/Notebooks $HOME/Documents/Notes/ $HOME/Programming /etc/nixos -name *.txt -o -name *.py -o -name *.sh -o -name *.bash -o -name *.nix | fzf-tmux --query="${1}". --prompt="Text> " --select-1 --exit-0 --multi --preview '~/.config/ranger/scope.sh {} 50 50 ~/.testing False' --preview-window=right:60 | sed -E 's/^(.*)$/"\1"/g')

echo $text | xargs nvim
