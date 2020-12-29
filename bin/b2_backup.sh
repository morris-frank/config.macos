#!/bin/env bash

declare -a dicts=("docs" "pictures" "music" "var/bitwig" "var/samples")
home='/home/morris/'
bucket='morris-cloud'

for dict in "${dicts[@]}"; do
    echo "[backup] now copying ${dict}"
    rclone sync -P --transfers=8 "${home}${dict}" "B2:${bucket}/${dict}"
done