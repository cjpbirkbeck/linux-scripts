#!/usr/bin/env bash
# Describe script here.
# Created on Tuesday December 04, 2018.
# Created by Christopher Birkbeck

if ( echo 'stuff' | socat - /tmp/mpvsockat ); then
  twmnc --title "Playing: " --content "$(echo '{"command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | jq '."data"')" --bg orange
else
  twmnc --title "Error: " --content "mpv is not playing right now."
fi
