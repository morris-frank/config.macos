#!/bin/env bash

for fil in `find . -type f`; do
    birthtime=$(stat -c '%w' $fil)
    if [[ $birthtime == '-' ]]; then
        continue
    fi

    ext="${fil##*.}"

    date=$(echo ${birthtime} | cut -d' ' -f1)
    hour=$(echo ${birthtime} | cut -d' ' -f2 | cut -d':' -f1)
    minute=$(echo ${birthtime} | cut -d' ' -f2 | cut -d':' -f2)

    echo "${date}_${hour}-${minute}.${ext}"
done
