#!/usr/bin/env bash

cd "$HOME/Music/Downloaded/" || exit 1

url="$1"

youtube -f 251 --add-metadata "$url"
