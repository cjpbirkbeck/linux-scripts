function name_is_free {
    if [[ -e "$1" ]]; then return 1; else return 0; fi
}

function name_no_initial_dash {
    if [[ "$1" =~ ^-(.*) ]]; then return 1; else return 0; fi
}

function rename_file {
    local old="$1"
    local new="$2"

    echo "Rename: ${old} ${new}"

    if name_is_free "$new" && name_no_initial_dash "$new"; then
        mv "$old" "$new"
    else
        return 1
    fi
}
