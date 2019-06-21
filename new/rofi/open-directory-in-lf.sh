#!/usr/bin/env bash
# Opens a terminal with a given directory, given by terminal.

next_dir="$(fasd -ldR | rofi -dmenu)"

temite --exec="bash -c lf ${next_dir}"
