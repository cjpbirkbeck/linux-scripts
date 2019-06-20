#!/usr/bin/env bash

for arg in "$@"; do
    if [ "$arg" = "--bg" ] & [ "$arg" = "--fg" ]; then
        echo "Background and forground already specified." >2
        exit 1
    fi
done

twmnc --bg yellow --fg black "$@"
