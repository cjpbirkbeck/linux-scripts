#!/usr/bin/env bash

# This will open up pdfs and epubs in zathura.

pdfs=$(find $HOME/Documents/ $HOME/Downloads/ -name *.pdf -o -name *.epub | fzf --multi --preview '~/.config/ranger/scope.sh {} 50 50 ~/.testing False' --preview-window=right:60 | sed -E 's/^(.*)$/"\1"/g')

echo $pdfs | xargs zathura --fork
