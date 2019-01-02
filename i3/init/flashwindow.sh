#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 24, 2018.
# Created by Christopher Birkbeck

cd "/home/cjpbirkbeck/Development/python3/flashfocus" || exit 1
nix-shell --run /home/cjpbirkbeck/Development/python3/flashfocus/_build/pip_packages/bin/flashfocus
