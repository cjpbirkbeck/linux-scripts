#!/usr/bin/env bash

cmus-remote --queue --clear
cmus-remote --queue "$1"
cmus-remote -C player-next
