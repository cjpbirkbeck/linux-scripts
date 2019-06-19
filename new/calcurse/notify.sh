#!/usr/bin/env bash

while true; do
    todays_apts="$(calcurse -a -d today --format-apt "%s %S %m\n" | sed -n '1!p')"

    if [[ -n $todays_apts ]]; then

done
