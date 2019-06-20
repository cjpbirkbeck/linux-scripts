#!/usr/bin/env bash
# Displays a notification in green

for arg in "$@"; do
    if [ "$arg" = "--bg" ]; then
        echo "Background already specified." >2
        exit 1
    fi
done

twmnc --bg green "$@"
