#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 17, 2018.
# Created by Christopher Birkbeck

cd "/home/cjpbirkbeck/Development/python3/flashfocus/" || exit 1
nix-shell --run /home/cjpbirkbeck/Development/python3/flashfocus/_build/pip_packages/bin/flash_window
twmnc --title " Current: " --content "$(xtitle | cut -c 1-64)" --bg green --duration 60
