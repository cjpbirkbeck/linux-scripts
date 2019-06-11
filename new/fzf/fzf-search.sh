#!/usr/bin/env bash

# This is a general script that allows searching certian files within some directories.
# Then it uses fzf along with a preview from ranger's scope.sh to preview stuff if it can.
# Note that this should read from a file for its search information.

# "$OPENER" "$(find ${location} ${condition} | fzf --preview ${previewer})"


