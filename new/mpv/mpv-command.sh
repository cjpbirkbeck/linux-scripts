#!/usr/bin/env bash
# Describe script here.
# Created on Tuesday December 04, 2018.
# Created by Christopher Birkbeck

echo "{\"command\" : [\"set_property\", \"${1}\", \"${2}\"] }" | socat - /tmp/mpv-socket | jq '."data"'
