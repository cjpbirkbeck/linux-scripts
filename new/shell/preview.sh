#!/usr/bin/env bash
# Generates a previews of a file, based on its file extension and mimetype.
# Otherwise, it prints out what finds.

set -C -f
IFS=$'\n'

# Arguments
FILE_PATH="${1}"
WINDOW_WIDTH="${2:-100}"
FILE_EXT="${FILE_PATH##*.}"
FILE_EXT_LOWER=$(echo "${FILE_EXT}" | tr '[:upper:]' '[:lower:]')

# Default colour style, used by highlight.
COLOUR_STYLE="pablo"
PRINT_COLOURS="ansi"

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
            atool --list -- "${FILE_PATH}"
            exit 1
            ;;
        pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fold
            exiftool "${FILE_PATH}" | fold
            exit 1
            ;;
        torrent)
            transmission-show -- "${FILE_PATH}" | fold
            exit 1
            ;;
        odt|ods|odp|sxw)
            odt2txt "${FILE_PATH}" --width="${WINDOW_WIDTH}" | fold
            exit 1
            ;;
        htm|html|xhtml)
            w3m -dump "${FILE_PATH}" | fold
            exit 1
            ;;
    esac
}

handle_mime() {
    local MIMETYPE="${1}"

    case "${MIMETYPE}" in
        text/* | */xml)
            detect_colour
            highlight --replace-tabs="4" --out-format="${PRINT_COLOURS}" \
                --style="${COLOUR_STYLE}" --wrap-simple --force -- "${FILE_PATH}"
            exit 2
            ;;
        # Images
        image/*)
            img2txt --gamma=0.6 -- "${FILE_PATH}" && exit 1
            exiftool "${FILE_PATH}"
            exit 1
            ;;
        video/*|audio/*|application/octet-stream)
            mediainfo "${FILE_PATH}"
            exifinfo "${FILE_PATH}"
            exit 1
            ;;
    esac
}

handle_fallback() {
    local mimetype="${1}"

    echo "Previewer cannot generate preview based on its extension or mimetype."
    echo "File Extension: ${FILE_EXT}"
    echo "Mime Type: ${mimetype}"
    exit 1
}

handle_extension
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}")"
handle_mime "${MIMETYPE}"
handle_fallback "${MIMETYPE}"

exit 1
