#!/usr/bin/env bash
# Describe script here.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

if [[ $(echo '{"command" : ["get_property", "pause"] }' | socat - /tmp/mpv-socket | jq .data) = "true" ]]; then
  echo '{"command" : ["set_property", "pause", false] }' | socat - /tmp/mpv-socket
else
  echo '{"command" : ["set_property", "pause", true] }' | socat - /tmp/mpv-socket
fi
