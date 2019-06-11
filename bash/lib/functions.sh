# Functions to load with bash, mostly to jump to various directories.

function fuzzy_cd {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

function fuzzy_open {
    local app="$1"

    selection="$(fasd -lRf | fzf -1 -0 --no-sort +m)"

    "$app" "$selection"
}

function nix_store_open {
if [ -n "$1" ]; then
  npath="$(nix path-info "$(command -v "$1")")"

  cd "$npath" || exit
else
  echo "No valid argument. exiting."
  exit 1
fi
}

function mkdir_cd {
    if [[ $# -eq 1 ]]; then
        mkdir -p "$1" && cd "$1" || exit 1
    else
        echo "Incorrect arguments." && exit 1
    fi
}

alias md="mkdir_cd"
alias j="fuzzy_cd"
alias e="fuzzy_open nvim"
alias ncd="nix_store_open"
