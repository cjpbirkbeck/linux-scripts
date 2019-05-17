#!/usr/bin/env bash

set -C -f -u 
IFS=$'\n'

# Script arguments
FILE_PATHS="${*}"
FILE_PATH="${1}"

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        txt)
            nvim "${FILE_PATH}"
            exit
            ;;
        jpg|gif|jpeg|png)
            nohup sxiv -a "${FILE_PATH}" &
            ;;
        # PDF
        pdf|epub)
            nohup zathura "${FILE_PATH}" &
            exit 1;;
        # OpenDocument
        odt|ods|odp|sxw)
            # Preview as text conversion
            odt2txt "${FILE_PATH}"
            exit 1;;

        # HTML
        htm|html|xhtml)
            # Preview as text conversion
            w3m -dump "${FILE_PATH}"
            ;; # Continue with next handler on failure
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        # Text
        text/* | */xml)
            # Syntax highlight
            "$HOME/Scripts/bash/cless" "${FILE_PATH}"
            exit 2;;

        # Image
        image/*)
            # Preview as text conversion
            nohup sxiv -a "${FILE_PATH}" &
            exit 1;;

        # Video and audio
        video/* | audio/*|application/octet-stream)
            nohup mpv -input-ipc-server=/tmp/mpvsocket "${FILE_PATH}" &
            exit 1;;
    esac
}

handle_fallback() {
    nohup xdg-open "${FILE_OPENER}" &
}


MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
