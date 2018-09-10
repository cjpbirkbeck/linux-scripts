#!/usr/bin/env bash
# Creates a Python 3 environment with nix-shell.
# Created on Monday September 10, 2018.
# Created by Christopher Birkbeck

new_syntax=false
py_packages=""
arg_pattern="-[a-zA-Z0-9_-]*"
verbose=false

while true; do
  case "$1" in
    -n | --new)
      new_syntax=true
      ;;
    -p | --packages)
      shift

      while true; do
        if [[ -z "$1" ]] || [[ "$0" =~ $arg_pattern ]]; then
          break
        else
          if ( $verbose ); then echo "Adding $1"; fi
          py_packages+="python36Packages.${1} "
          shift
        fi
      done
      ;;
    -V|--verbose)
      verbose=true
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

echo "$py_packages"

if ( $new_syntax ); then
  nix run
else
  if ($verbose); then echo "nix-shell --packages python3 $py_packages --run python --show-trace"; fi
  nix-shell --packages python3 $py_packages --run python --show-trace
fi
