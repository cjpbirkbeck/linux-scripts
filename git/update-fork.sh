#!/usr/bin/env bash
# Helps to keep a forked master up to date with the original master.
# Created on Friday August 03, 2018.
# Created by Christopher Birkbeck

if [ -n "$1" ]; then
  cd "$1" || echo "Error. Cannot find directory $1. Exiting."
  git status

  if [ "$2" -ne 128 ]; then
    git fetch upstream
    
    git merge upstream/master
    git push -u origin master
  else
    echo "Cannot find a git repository!"
    exit
  fi
else
  echo "Error. Rquires an argument."
fi
