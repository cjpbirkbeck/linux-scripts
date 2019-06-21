#!/usr/bin/env bash
# Opens a terminal with a given directory, given by terminal.

fasd -ldR | rofi -dmenu | xargs --null termite -d
