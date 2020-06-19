#!/bin/env bash

UUID='5B8A-D02E'
home='/home/morris/docs/lib/e-Reader'

disk_path="/dev/disk/by-uuid/${UUID}"
if [ ! -e "${disk_path}" ]; then
    echo "[kindlecopy] did not find the Kindle connected."
    exit 0
fi

mnt=$(lsblk -dno MOUNTPOINT "${disk_path}" | tr -d "[:space:]")

# If not mounted then mount if
if [ -z "$mnt" ]; then
    echo "[kindlecopy] mounting……"
    udisksctl mount -b "${disk_path}" &> /dev/null
    sleep 2
    mnt=$(lsblk -dno MOUNTPOINT "${disk_path}" | tr -d "[:space:]")
fi

echo "[kindlecopy] mounted @ ${mnt}/"

echo "[kindlecopy] now copying"
find "${home}" -type f -print0 |
    while IFS= read -r -d '' line; do
        if [ "${line: -5}" == ".epub" ]; then
            basen=$(basename "${line}")
            ebook-convert "${line}" "${mnt}/documents/${basen:0:-5}.mobi"
        fi
    done

udisksctl unmount -b "${disk_path}" &> /dev/null
