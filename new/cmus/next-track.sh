#!/usr/bin/env bash
# Play next track, and show display a notification.
# Created by Christopher Birkbeck

cmus-remote --next >2 /dev/null
./get-current-title.sh
