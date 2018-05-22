#!/bin/sh
# Send output and errors to Termbin.com to print it out.

# Check if the user want to create seperate standard output and error files.
# Otherwise, put them in the same file.
if [[ "$1" = "-s" ]] || [[ "$1" = "--seperate" ]]
then
  shift

  name=$1
  whole_command=$@

  $whole_command 1> "/tmp/.{$name}stdout" 2> "/tmp/.{$name}stderr"

  cat "/tmp/.{$name}stdout" | nc termbin.com 9999
  cat "/tmp/.{$name}stderr" | nc termbin.com 9999
else
  $@ 2>&1 | nc termbin.com 9999 
fi
