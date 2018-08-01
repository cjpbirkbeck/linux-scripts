#!/usr/bin/env bash
# Creates a new html file from a blank template.
# Created on Sunday July 15, 2018.
# Created by Christopher Birkbeck

function styling {
  local html="$1"
  local seperate=${2:-false}
  local name=${3:-page}

  if ( $seperate ); then
    ex --command 5,9d $html
    cp ./page.css ./$html.css
  else
    ex --command 10d $html
  fi

}

for new_page in "$@"; do
  cp ~/Templates/page.html .
  mv ./page.html ./$new_page.html
done
