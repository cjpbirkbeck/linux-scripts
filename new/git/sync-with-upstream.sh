#!/usr/bin/env bash
# Helps to keep a forked master up to date with the original master.
# Created on Friday August 03, 2018.
# Created by Christopher Birkbeck

if [ -n "$1" ]; then
  cd "$1" ||  { echo "Error. Cannot find directory $1. Exiting."; exit 1; }
fi

git status

if [ "$?" -ne 128 ]; then
  git fetch upstream

  git merge upstream/master
  git push -u origin master
else
  echo "Cannot find a git repository!" >&2
  exit 1
fi
