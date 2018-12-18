#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 17, 2018.
# Created by Christopher Birkbeck

twmnc --title "Current: " --content "$(xtitle | cut -c 1-64)" --bg green --duration 60
