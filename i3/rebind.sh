#!/usr/bin/env bash
# Changes caps lock into Control_L and makes it Escape when held down.
# Created on Friday December 07, 2018.
# Created by Christopher Birkbeck

setxkbmap -option ctrl:nocaps
pkill xcape; xcape -e 'Control_L=Escape'
