#!/usr/bin/env bash

~/Scripts/new/fzf/lookfor.sh $(printf "audio\nbooks\nimage\nman\nmusic\nvideo\n" | rofi -dmenu -i -only-match )
