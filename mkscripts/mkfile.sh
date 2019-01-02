#!/usr/bin/env bash
# Describe script here.
# Created on Monday December 24, 2018.
# Created by Christopher Birkbeck

templates="$HOME/Templates"

function mvtemplate {
  local name="$1"
  local filetype="$2"
  local suffix="$3"

  cp "${templates}/${filetype}.${suffix}" "./${name}.${suffix}"
}


