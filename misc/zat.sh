#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 24, 2018.
# Created by Christopher Birkbeck

zathura --fork "$(find $HOME/Documents/Books/ $HOME/Documents/Papers $HOME/Documents/Rulebooks -name *.pdf -o -name *.epub -o -name *.djvu -o -name *.cb | fzf --multi --exit-0 --select-1 --preview '$HOME/.config/ranger/scope.sh {} 40 40 ~/.testing False')"
