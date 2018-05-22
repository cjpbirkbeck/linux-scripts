#!/bin/sh
# Sends a command to the mpv socket to unpause a currently paused video.

echo '{"command" : ["set_property", "pause", false] }' | socat - /tmp/mpvsocket
