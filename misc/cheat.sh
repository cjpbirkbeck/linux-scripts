#!/usr/bin/env bash
# Describe script here.
# Created on Thursday December 20, 2018.
# Created by Christopher Birkbeck

nix-shell --package rlwrap --command "$HOME/Development/Shell/cht.sh" "${@}"
