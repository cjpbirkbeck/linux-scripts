#!/usr/bin/env bash
# Downloads Youtube en-mass via youtube-dl to a new directory and strips out the spaces with underscores.
# Created on Wednesday August 01, 2018.
# Created by Christopher Birkbeck

while true; do
  case "$1" in
    -d|--directory)
      if [ -n "$2" ]; then
        new_dir="$1"
      else
        echo "Error. No directory specified. Exiting"
        exit 1
      fi
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac

  shift
done

# cd ~/Music
if [ -z "$new_dir" ]; then
  new_dir="$(date '+%B_%d_%Y_%H_%M')"
fi

mkdir $new_dir && cd $new_dir

if [ "$?" -ne 0 ]; then
  echo "Error. Cannot make or change to $new_dir. Exiting."; exit 1; 
fi

for arg in "$@"; do
  youtube-dl -f 140 "$arg"
done

detox *
