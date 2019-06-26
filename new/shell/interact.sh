#!/usr/bin/env bash

# Script will detect file and either PREVIEW, PAGE, EDIT or OPEN
# PREVIEW: Show a textual representation of the file.
# PAGE: Page through through that repsentation of that file.
# EDIT: Open the file in its most 'natual' editor.
# OPEN: Open the file in the most 'natural' graphical application.

set -C -f
IFS=$'\n'

MODE="page"

if [[ "${1}" = "preview" ]] && [[ "${1}" = "page" ]] && \
   [[ "${1}" = "edit" ]] && [[ "${1}" = "open" ]]; then
    MODE="${1}"
else
    exit 10
fi

# Process the file extension.
FILE_PATH="${2}"
WINDOW_WIDTH="${3:-60}"
FILE_EXT="${FILE_PATH##*.}"
FILE_EXT_LOWER=$(echo "${FILE_EXT}" | tr '[:upper:]' '[:lower:]')

# Default colour style, used by highlight.
COLOUR_STYLE="pablo"
PRINT_COLOURS="ansi"

# These functions will preform actions based on type and mode.
process_plain_text() {
    case "${MODE}" in
        preview)
            fold --width=60 --spaces "${FILE_PATH}"
            exit 2
            ;;
        page)
            fold --width=60 --spaces "${FILE_PATH}" | less --line-numbers
            ;;
        edit)
            nvim "${FILE_PATH}"
            ;;
        open)
            nvim "${FILE_PATH}"
            ;;
    esac
}

# This should detect if the exact colours codes to be used.
detect_colour() {
    if [ -n "$COLORTERM" ]; then
        PRINT_COLOURS="truecolor"
    elif [ "$( tput colors )" -ge 256 ]; then
        PRINT_COLOURS="xterm256"
    fi
}

handle_extension() {
    case "${FILE_EXT_LOWER}" in
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            process_archives
            ;;
        pdf)
            process_pdfs
            ;;
        torrent)
            process_torrents
            ;;
        odt|ods|odp|sxw)
            process_opendocs
            ;;
        htm|html|xhtml)
            handle_html
            ;;
        json)
            handle_json
            ;;
    esac
}

handle_mime() {
    local MIMETYPE="${1}"

    case "${MIMETYPE}" in
        text/plain)
            process_plain_text
            ;;
        text/* | */xml)
            process_structured_text
            ;;
        # Images
        image/*)
            process_image
            ;;
        video/*|audio/*|application/octet-stream)
            process_video
            ;;
    esac
}

handle_fallback() {
    local mimetype="${1}"

    echo "Script cannot process file based on its extension or mimetype."
    echo "File Extension: ${FILE_EXT}"
    echo "Mime Type: ${mimetype}"
    exit 1
}

handle_extension
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}")"
handle_mime "${MIMETYPE}"
handle_fallback "${MIMETYPE}"

