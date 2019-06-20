#!/usr/bin/env bash

# Writes any notifications to a simple text file.

date_time="$(date '+%s')"
title="Unknown title"
message="Unkown message"

while "$#" -gt 0; do
    current_arg="$1"
    case "$current_arg" in
        -t|--title)
            title="$2"
            shift
            ;;
        -c|--content)
            message="$2"
            shift
            ;;
        *)
            ;;
    esac
    shift
done

echo "$date_time	$title	$message" >> ~/.twmnc_history
