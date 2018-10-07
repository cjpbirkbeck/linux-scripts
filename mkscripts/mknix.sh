#!/usr/bin/env bash
# Generates nix files as need be.
# Created on Thursday September 27, 2018.
# Created by Christopher Birkbeck

nixos_config=false
comment="Insert comment here."
initial_line=" "

function generate {
  name="${1}.nix"

  if ( $nixos_config ); then
    initial_line=" config, pkgs, ... "
  fi

  { echo -e "# $comment\\n\\n";
    echo -e "{$initial_line}: ";
    echo -e "\\n{\\n  # Contents go here.\\n\\n}"; } > "$name"
}

for file in "$@"; do
  generate "$file"
done
