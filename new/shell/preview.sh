#!/usr/bin/env bash
# Generates a previews of a file, based on its file extension and mimetype.
# Otherwise, it prints out what finds.

# Based off Ranger's scope.sh and a suggested revision for lf.
# Latest Ranger scope.sh: https://github.com/ranger/ranger/blob/master/ranger/data/scope.sh
# Suggested lf scope.sh: https://github.com/gokcehan/lf/wiki/Ranger

set -C -f
IFS=$'\n'

# Arguments
FILE_PATH="${1}"
WINDOW_WIDTH="${2:-60}"
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

process_pdf () {
    pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fold --spaces --width="${WINDOW_WIDTH}"
    exiftool "${FILE_PATH}" | fold --spaces --width="${WINDOW_WIDTH}"
    exit 1
}

process_epub () {
    # NOTE: pandoc is quite slow, slower than should allowed for a script
    # like this. It should be replace with something like epub2txt2, if I
    # can get it to work.
    pandoc -i "${FILE_PATH}" --to=plain | fold --spaces --width="${WINDOW_WIDTH}"
    exit 1
}

process_extension() {
    atool --list -- "${FILE_PATH}"
    exit 1
}

process_torrent() {
    transmission-show -- "${FILE_PATH}" | fold
    exit 1
}

process_opendocs() {
    odt2txt "${FILE_PATH}" --width="${WINDOW_WIDTH}" | fold
    exit 1
}

process_ms_word() {
    catdoc "${FILE_PATH}" | fold
    exit 1
}

process_ms_wordx() {
    catdocx "${FILE_PATH}" | fold
    exit 1
}

process_json() {
    jq --color-output . "${FILE_PATH}" | fold
    exit 1
}

process_html() {
    w3m -dump "${FILE_PATH}" | fold
    exit 1
}

process_plain_text() {
    fold --width=60 --spaces "${FILE_PATH}"
    exit 2
}

process_struct_text() {
    detect_colour
    highlight --replace-tabs="4" --out-format="${PRINT_COLOURS}" \
        --style="${COLOUR_STYLE}" --wrap --line-length="${WINDOW_WIDTH}" --force -- "${FILE_PATH}"
    exit 2
}

process_image() {
    img2txt --gamma=0.6 -- "${FILE_PATH}" && exit 1
    exiftool "${FILE_PATH}"
    exit 1
}

process_multimedia() {
    mediainfo "${FILE_PATH}" | fold --width=60 --spaces
    exiftool "${FILE_PATH}" | fold --width=60 --spaces
    exit 1
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
        epub)
            # NOTE: pandoc is quite slow, slower than should allowed for a script
            # like this. It should be replace with something like epub2txt2, if I
            # can get it to work.
            pandoc -i "${FILE_PATH}" --to=plain | fold
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
        json)
            jq --color-output . "${FILE_PATH}" | fold
            exit 1
            ;;
        doc)
            catdoc "${FILE_PATH}" | fold
            exit 1
            ;;
        docx)
            catdocx "${FILE_PATH}" | fold
            exit 1
    esac
}

handle_mime() {
    local MIMETYPE="${1}"

    case "${MIMETYPE}" in
        text/plain)
            fold --width=60 --spaces "${FILE_PATH}"
            exit 2
            ;;
        text/* | */*xml)
            detect_colour
            highlight --replace-tabs="4" --out-format="${PRINT_COLOURS}" \
                --style="${COLOUR_STYLE}" --wrap --line-length="${WINDOW_WIDTH}" --force -- "${FILE_PATH}"
            exit 2
            ;;
        # Images
        image/*)
            img2txt --gamma=0.6 -- "${FILE_PATH}" && exit 1
            exiftool "${FILE_PATH}"
            exit 1
            ;;
        video/*|audio/*|application/octet-stream)
            mediainfo "${FILE_PATH}" | fold --width=60 --spaces
            exiftool "${FILE_PATH}" | fold --width=60 --spaces
            exit 1
            ;;
    esac
}

handle_fallback() {
    local mimetype="${1}"

    echo "Previewer cannot generate a preview based on its extension or mimetype."
    echo "File Extension: ${FILE_EXT}"
    echo "Mime Type: ${mimetype}"
    exit 1
}

handle_extension
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}")"
handle_mime "${MIMETYPE}"
handle_fallback "${MIMETYPE}"

exit 1
