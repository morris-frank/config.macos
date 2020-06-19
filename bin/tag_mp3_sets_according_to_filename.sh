#!/bin/env bash

folder="$(xdg-user-dir MUSIC)/sets/"

for filepath in "$folder"*.mp3; do
    name=$(basename "${filepath}")
    artist=$(echo "${name}" | cut -d"@" -f1 | xargs)
    title=$(echo "${name}" | cut -d"@" -f2 | xargs)
    title="${title:0:-4}"
    id3tag -a "${artist}" -s "${title}" "${filepath}"
done
