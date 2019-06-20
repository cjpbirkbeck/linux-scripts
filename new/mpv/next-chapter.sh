#!/usr/bin/env bash

if ( ./mpv-socket-exits.sh ); then
    ./mpv-command "time-pos" 0
fi
