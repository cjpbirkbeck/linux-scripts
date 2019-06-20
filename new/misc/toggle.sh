#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 24, 2018.
# Created by Christopher Birkbeck

if pgrep cmus && pgrep mpv; then
    true
fi
