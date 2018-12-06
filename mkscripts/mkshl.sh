#!/usr/bin/env bash
# Creates various shell scripts.

# name=script
shell_type=bash
mk_nix_shell=false
real_interpreter="bash"
public=false
suffix=true
in_bin=false
sub=misc

declare -A hashbang=( \
  ["bourne"]="#!/bin/sh" \
  ["bash"]="#!/usr/bin/env bash" \
  ["nix"]="#!/usr/bin/env nix-shell" \
  ["zsh"]="#!/usr/bin/env zsh")

# Creates the file and put some starting information.
create () {
  local name="$1"
  local original="$1"

  if ( $suffix ); then
    name+=".sh"
  fi

  { echo -e "${hashbang[${shell_type}]}";
  if ( $mk_nix_shell ) ; then
    echo -e "#! nix-shell -i ${real_interpreter} # Put options here. ";
  fi
  echo -e "# Describe script here.";
  echo -e "# Created on $(date '+%A %B %d, %Y').";
  echo -e "# Created by Christopher Birkbeck"; } >> $name

  local location=$(readlink -f $name)

  if [[ $location =~ $HOME/Scripts/* ]]; then
    echo -e "alias $original=\"$location\"" >> "$HOME/Scripts/shortcuts"
  fi
}

# Makes the script executable.
mkexec () {
  local name="$1"

  if ( $suffix ); then
    name+=".sh"
  fi

  if [ ! $public ]; then
    chmod 700 $name
  else
    chmod 755 $name
  fi
}

# Process arguments
while true ; do
  case $1 in
    -b|--bin)
      if [ -n "$2" ] && [ "${2:0}" != "-" ]; then
        sub="$2"
        cd "$HOME/Scripts/$sub" || mkdir "$HOME/Scripts/$sub"
        shift
      else
        sub="misc"
        cd "./$HOME/Scripts/misc" || mkdir "$HOME/Scripts/misc"
      fi

      if [[ "$?" -ne 0 ]]; then
        echo "Cannot find bin or $sub directories. Exiting."
        exit 1
      fi
      ;;
    -h|-\?|--help)
      usage
      exit
      ;;
    -l|--location)
      if [ "$2" ]; then
        cd "$2" || { echo "Cannot find directory $2 . Exiting"; exit 1; }
        shift
      else
        echo "No directory specifed. Exiting"
        exit 1
      fi
      ;;
    -n|--no-suffix)
      suffix=false
      shift
      ;;
    -p|--public)
      public=true
      shift
      ;;
    -t|--type)
      if [ "$2" ]; then
        case "$2" in
          bourne|sh)
            shell_type="bourne"
            ;;
          bash)
            shell_type="bash"
            ;;
          nix)
            shell_type="nix"
            mk_nix_shell=true
            if [ "$3" ]; then
              case "$3" in
                bash)
                  real_interpreter="bash"
                  ;;
                python)
                  real_interpreter="python"
                  ;;
                *)
                  ;;
              esac

              shift
            fi
            ;;
          zsh)
            shell_type="zsh"
            ;;
          *)
            echo "Unknown shell type specified. Exiting."
            exit 1
            ;;
        esac
      else
        echo "No type specified. Defaulting to bash"
      fi
      ;;
    --)
      shift
      break
      ;;
    -?*)
      printf 'Unknown option ignored: %s\n' "$1" >&2
      ;;
    *)
      break
  esac

  shift
done

for command in "$@"; do
  create "$command"
  mkexec "$command"
done
