#!/bin/sh
# Sends a command to the mpv socket to pause a currently playing video.

echo '{"command" : ["set_property", "pause", true] }' | socat - /tmp/mpvsocket
