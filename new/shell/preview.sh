#!/usr/bin/env bash

set -C -f -u
IFS=$'\n'

# Arguments
FILE_PATH="${1}"

FILE_EXT="${FILE_PATH##*.}"
FILE_EXT_LOWER=$(echo ${FILE_EXT} | tr '[:upper:]' '[:lower:]')

handle_extension() {
    case "${FILE_EXT_LOWER}" in
        pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}"
            exiftool "${FILE_PATH}"
            ;;
        odt|ods|odp|sxw)
            odt2txt "${FILE_PATH}"
            ;;
        htm|html|html)
            w3m -dump "${FILE_PATH}"
            ;;
    esac
}

handle_mime() {
    local MIMETYPE="${1}"

    case "${MIMETYPE}" in
        text/* | */xml)
            if [ "$( stat --printf='%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]; then
                exit 2
            fi
            if [ "$( tput colors )" -ge 256 ]; then
                local pygmentize_format='terminal256'
                local highlight_format='xterm256'
            else
                local pygmentize_format='terminal'
                local highlight_format='ansi'
            fi
            highlight --replace-tabs="${HIGHLIGHT_TABWIDTH}" --out-format="${highlight_format}" \
                --style="${HIGHLIGHT_STYLE}" --force -- "${FILE_PATH}"
            exit 2;;
        # Images
        image/*)
            img2txt --gamma=0.6 -- "${FILE_PATH}" && exit 1
            exiftool "${FILE_PATH}"
            ;;
        video/*|audio/*|application/octet-stream)
            mediainfo "${FILE_PATH}"
            mediainfo "${FILE_PATH}"
            ;;
    esac
}

handle_fallback() {
    local mimetype="${1}"

    echo "Error. Previewer cannot generate preview based on its extension or mimetype."
    echo "File Extension: ${file_ext}"
    echo "Mimetype: ${mimetype}"
}

handle_extension
MIMETYPE="$( file --deference --brief --mime-type -- "${FILE_PATH}")"
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
