#!/usr/bin/env bash

cd "$HOME/Videos/Downloaded/" || exit 1

url="$1"

youtube --add-metadata "$url"
