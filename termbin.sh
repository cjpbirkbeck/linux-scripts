#!/bin/sh
# Send output and errors to Termbin.com to print it out.

# Check if the user wants to just have stdout and stderr interacted with each other, or wants more processing done on the file.
if [[ "$1" = "-s" ]] || [[ "$1" = "--seperate" ]] || [[ "$1" = "-c" ]] | [[ "$1" = "--concatinate" ]];then
  shift

  name=$1
  whole_command=$@

  $whole_command 1> "/tmp/.$name-stdout" 2> "/tmp/.$name-stderr"

  # Check if the user either wants stdout and stderr to be seperate file on in a single file.
  if [[ "$1" = "-s" ]] || [[ "$1" = "--seperate" ]]; then
    cat "/tmp/.$name-stdout" | nc termbin.com 9999
    cat "/tmp/.$name-stderr" | nc termbin.com 9999
  elif [[ "$1" = "-c" ]] | [[ "$1" = "--concatinate" ]]; then
   echo -e "Input: $whole_command\nStandard Output:\n\n $(cat "/tmp/.$name-stdout")\n\nStandard Error:\n\n $(cat "/tmp/.$name-stderr")" | nc termbin.com 9999
  fi
else
  $@ 2>&1 | nc termbin.com 9999
fi
