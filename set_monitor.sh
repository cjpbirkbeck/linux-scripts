#!/bin/sh

# This should set the monitors properly.

xrandr --newmode "1280x1024_60.00"  109.00  1280 1368 1496 1712  1024 1027 1034 1063
xrandr --addmode VGA1 1280x1024_60.00
xrandr --output VGA1 --mode 1280x1024_60.00
