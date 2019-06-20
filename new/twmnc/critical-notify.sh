#!/usr/bin/env bash

for arg in "$@"; do
    if [ "$arg" = "--bg" ]; then
        echo "Background already specified." >2
        exit 1
    fi
done

twmnc --bg red "$@"
