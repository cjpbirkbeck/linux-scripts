#!/usr/bin/env bash
# Describe script here.
# Created on Wednesday December 05, 2018.
# Created by Christopher Birkbeck

if ( pgrep cmus ); then
  cmus=$(cmus-remote -Q)
  status=$(echo -e "${cmus}" | awk ' /status/ { print $2 }' | sed -E -e 's/\b[a-z]/\u&/g')
  title=$(echo -e "${cmus}" | grep -E -n 'tag title' | sed -E -e 's/tag title//g' -e 's/\b[a-z]/\u&/g')

  twmnc --title " ${status} " --content "${title}"
else
  twmnc --title "Error " --content "cmus is not opened."
fi
