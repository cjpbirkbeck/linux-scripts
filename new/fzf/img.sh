#!/usr/bin/env bash

# Searches the Pictures directories for jpeg, gif and png files.

images=$(find ~/Pictures/ -name *.png* -o -name *.jpg* | fzf-tmux --multi --preview '~/.config/ranger/scope.sh {} 50 50 ~/.testing False' --preview-window=right:50)

(setsid sxiv $images &)
