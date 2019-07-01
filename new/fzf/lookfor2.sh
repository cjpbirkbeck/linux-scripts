#!/usr/bin/env bash

locations="$HOME"
file_regex=""
fzf_prompt=""
previewer="$HOME/Scripts/new/shell/preview.sh"
open_with="xdg-open"
fork_it=false

find_man() {
    man -k . | fzf-tmux --prompt="Man> " --print0 --multi --select-1 --exit-0 --preview="man {1}" | xargs --null ./process_man.sh
}

case "$1" in
    "audio" | "Audio")
        locations="$HOME/Audio $HOME/Music"
        file_regex="\.(ogg|mp3|wma|webm)$"
        fzf_prompt="Audio> "
        open_with="./process_audio.sh"
        ;;
    "books" | "Books")
        locations="$HOME/Documents $HOME/Downloads"
        file_regex="\.(epub|pdf)$"
        fzf_prompt="eBooks> "
        open_with="zathura --fork"
        fork_it=true
        ;;
    "images" | "Images")
        locations="$HOME/Pictures $HOME/Downloads"
        file_regex="\.(png|jpg|gif|bmp)$"
        fzf_prompt="Images> "
        open_with="sxiv -a"
        fork_it=true
        ;;
    "text")
        locations="$HOME/Documents/Plain-Text/ $HOME/Downloads"
        file_regex="\.(txt)$"
        fzf_prompt="Plain> "
        open_with="nvim"
        ;;
    "man" | "Manpages")
        find_man
        exit 1
        ;;
    "music" | "Music")
        locations="$HOME/Music $HOME/Downloads"
        file_regex="\.(ogg|mp3|wma|webm)$"
        fzf_prompt="Music> "
        open_with="./process_audio.sh"
        ;;
    "video" | "Video")
        locations="$HOME/Videos $HOME/Downloads"
        file_regex="\.(avi|mkv|mp4|webm)$"
        fzf_prompt="Videos> "
        open_with="mpv --no-terminal --really-quiet "
        fork_it=true
        ;;
    *)
        ;;
esac

selected="$(fd --type file "${file_regex}" ${locations} | fzf-tmux --prompt="${fzf_prompt}" --multi --select-1 --exit-0 --preview="${previewer} {}")"

if [ -z "$selected" ]; then exit 0; fi

if [ $fork_it = true ]; then
    setsid --fork $open_with "$selected"
else
    echo "$selected" | tr '\n' '\0' | xargs --null $open_with
fi
