#!/bin/bash

declare -a dicts=("docs" "pictures" "music")
# The UUID of the HDD
UUID='EE6426CE6426997B'
# The root dict of the home, pivot of left side
home='/home/morris/'

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

for dict in "${dicts[@]}"; do
    rsync -ah --stats "${home}/${dict}" "${mnt}/"
done

udisksctl unmount -b "${disk_path}" &> /dev/null
