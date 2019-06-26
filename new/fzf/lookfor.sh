#!/usr/bin/env bash

# Script for looking for various items on my home drive.

if [[ -z "$1" ]]; then printf 'Needs either a qualifer or a term to start processing' >2; exit 1; fi

use_find=true
locations="$HOME"
file_types=""
fzf_prompt="Any> "
previewer="$HOME/Scripts/new/shell/preview.sh"
open_with="xdg-open"

case "$1" in
    "audio"|"a")
        # Requires a script to work with cmus.
        locations="$HOME/Music/ $HOME/Audio/ $HOME/Downloads/ "
        file_types="-name *.ogg -o -name *.mp3 -o -name *.wma -o -name *.webm "
        fzf_prompt="Audio> "
        open_with="./process_audio.sh"
        ;;
    "books"|"b")
        # "Books" includes any finished, published materials.
        locations="$HOME/Documents/ $HOME/Downloads/ "
        file_types="-name *.pdf -o -name *.epub "
        fzf_prompt="Books> "
        open_with="zathura --fork"
        ;;
    "images"|"i")
        locations="$HOME/Pictures/ $HOME/Downloads/ "
        file_types="-name *.png* -o -name *.jpg* -o -name *.gif* -o -name *.bmp* "
        fzf_prompt="Images> "
        open_with="sxiv -a"
        ;;
    "text"|"t")
        # Text here is only plain text kept within a given folder.
        locations="$HOME/Documents/Plain-Texts "
        fzf_prompt="Text> "
        open_with="nvim"
        ;;
    "man")
        # Searches various man pages. Note this requires another script to work.
        find_command="man -k ."
        use_find=false
        fzf_prompt="Man> "
        previewer="man {1}"
        open_with="./process_man.sh"
        ;;
    "music"|"m")
        # For searching Music only.
        locations="$HOME/Music $HOME/Downloads "
        file_types="-name *.ogg -o -name *.mp3 -o -name *.wma "
        fzf_prompt="Music> "
        open_with="./process_audio.sh"
        ;;
    "video"|"v")
        locations="$HOME/Videos $HOME/Downloads "
        file_types="-name *.avi -o -name *.mkv -o -name *.mp4 -o -name *.webm "
        fzf_prompt="Video> "
        open_with="mpv"
        ;;
    *)
        true
        ;;
esac

# Get the choices from whatever command can process them.
if [[ "$1" != "man" ]]; then
    choices="$(find ${locations} ${file_types})"
elif [[ "$1" = "man" ]]; then
    choices="$(man -k .)"
fi

echo "$choices" | fzf-tmux --prompt="${fzf_prompt}" --print0 --multi --select-1 --exit-0 --preview="${previewer} {}" | xargs --null $open_with

