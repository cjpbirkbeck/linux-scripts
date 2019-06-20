#!/usr/bin/env bash
# This creates a flashing effect whenever windows are changed.
# Created by Christopher Birkbeck

cd "/home/cjpbirkbeck/Development/python3/flashfocus" || exit 1
nix-shell --run /home/cjpbirkbeck/Development/python3/flashfocus/_build/pip_packages/bin/flashfocus
