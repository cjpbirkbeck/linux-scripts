#!/usr/bin/env bash
# Creates environment for developing python.
# Created on Tuesday August 21, 2018.
# Created by Christopher Birkbeck

if ( ! tmux has-session -t Python_3 ); then
  # Set up the first window for nvim and the REPL.
  tmux new-session -s Python_3 -n Editor -d
  tmux send-keys -t Python_3 'nvim' C-m
  tmux split-window -v -t Python_3
  tmux select-layout -t Python_3 main-horizontal

  # Set up the python REPL in the botom screen with the editor
  tmux send-keys -t Python_3:1.2 'cd ~/Environments/python/3-6/' C-m
  tmux send-keys -t Python_3:1.2 'nix-shell' C-m
  tmux send-keys -t Python_3:1.2 'python' C-m

  # Have a general nix-shell to work with if need be.
  tmux new-window -n Console -t Python_3
  tmux send-keys -t Python_3:2 'cd ~/Environments/python/3-6/' C-m
  tmux send-keys -t Python_3:2 'nix-shell' C-m
fi

# Open documentation in the background.
qutebrowser --restore python-docs 2> /dev/null &
disown qutebrowser

tmux attach -t Python_3
