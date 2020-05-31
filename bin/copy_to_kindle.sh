#!/bin/env bash

# The UUID of the HDD
UUID='5B8A-D02E'
# The root dict of the home, pivot of left side
home='/home/morris/docs/lib/e-Reader'

disk_path="/dev/disk/by-uuid/${UUID}"
if [ ! -e "${disk_path}" ]; then
    echo "[backup] did not find the HDD connected."
    exit 0
fi

mnt=$(lsblk -dno MOUNTPOINT "${disk_path}" | tr -d "[:space:]")

# If not mounted then mount if
if [ -z "$mnt" ]; then
    echo "[backup] mounting……"
    udisksctl mount -b "${disk_path}" &> /dev/null
    sleep 2
    mnt=$(lsblk -dno MOUNTPOINT "${disk_path}" | tr -d "[:space:]")
fi

echo "[backup] mounted @ ${mnt}/"

echo "[backup] now copying"
rsync -ah --info=progress2 "${home}" "${mnt}/documents/"

udisksctl unmount -b "${disk_path}" &> /dev/null
