#!/bin/env bash

rootd='/home/morris/docs/lib/e-Reader'
targetd='/run/media/morris/Kindle/documents'
find "${rootd}" -type f -print0 |
    while IFS= read -r -d '' line; do
        if [ "${line: -5}" == ".epub" ]; then
            basen=$(basename "${line}")
            ebook-convert "${line}" "${targetd}/${basen:0:-5}.mobi"
        fi
    done
