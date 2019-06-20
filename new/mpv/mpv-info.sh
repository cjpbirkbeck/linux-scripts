#!/usr/bin/env bash
# Describe script here.
# Created on Tuesday December 04, 2018.
# Created by Christopher Birkbeck

echo "{\"command\" : [\"get_property\", \"${1}\"] }" | socat - /tmp/mpv-socket | jq '."data"'
