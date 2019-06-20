#!/usr/bin/env bash

if ( echo 'hello' | socat - /tmp/mpv-socket ); then
    exit 0
else
    exit 1
fi
