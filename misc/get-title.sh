#!/usr/bin/env bash
# Describe script here.
# Created on Tuesday December 04, 2018.
# Created by Christopher Birkbeck

echo '{"command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | jq '."data"'
