#!/bin/bash
set -e

# Compressor options
ITERATIONS=100

usage() {
    (
    cat <<EOF
Zopfli Recompressor

Usage:
    zopfli-recompress.sh <input-directory> <file-extension> <number-of-threads> <progress-file>

Example:
    zopfli-recompress.sh /my/directory/with/files zip 8 ./progress.log

    This command will recompress all files within '/my/directory/with/files',
    which have the file ending of .zip. Eight files will be processed in parallel.
    The progress will be logged to a file named 'progress.log' in the current directory.
    If the process is started again the last progress will be loaded from the log in order
    to resume operation.

EOF
    ) >&2
}

cleanup() {
    if [ -f "${FILE_LIST}" ]; then
        rm -f "${FILE_LIST}" >/dev/null 2>&1 || true
    fi
}

if [ "$#" -lt "4" ]; then
    usage
    exit 1
fi

INPUT_DIR="$1"
EXTENSION="$2"
THREADS="$3"
PROGRESS_LOG="$4"

FILE_LIST="$(mktemp)"
trap cleanup "EXIT"

echo -n "Scanning for files to recompress..."
find "${INPUT_DIR}" -iname "*.${EXTENSION}" >"${FILE_LIST}"
FILE_COUNT="$(cat "${FILE_LIST}" | wc -l)"
echo " ${FILE_COUNT} files found."

echo "Starting to recompress..."

cat "${FILE_LIST}" | parallel --progress --bar --eta --joblog "${PROGRESS_LOG}" -j "${THREADS}" --resume "advzip --recompress -4 --iter ${ITERATIONS} "'{}'