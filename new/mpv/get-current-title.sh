#!/usr/bin/env bash
# Describe script here.
# Created on Tuesday December 04, 2018.
# Created by Christopher Birkbeck

if ( echo 'hello' | socat - /tmp/mpv-socket ); then
  twmnc --title "Playing " --content "$(echo '{"command": ["get_property", "media-title"] }' | socat - /tmp/mpv-socket | jq '."data"')"
else
  twmnc --title "Error" --content "mpv is not playing right now."
fi
