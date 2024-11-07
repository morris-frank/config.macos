#!/bin/zsh

# This script deletes all .RAW-02.ORIGINAL.dng files that do not have a
# corresponding .RAW-01.MP.COVER.jpg or .RAW-01.COVER.jpg file.

# Folder with the JPGs and DNGs
directory="$HOME/Desktop/pxl"
delete=false
deleted_count=0

# Check for -f option
if [[ "$1" == "-f" ]]; then
    delete=true
fi

# Find all .RAW-02.ORIGINAL.dng files
for dng_file in "$directory"/*.RAW-02.ORIGINAL.dng; do
    # Extract the prefix by splitting by '.' and taking the first part
    prefix="${dng_file##*/}"
    prefix="${prefix%%.*}"

    # Check if neither .RAW-01.MP.COVER.jpg nor .RAW-01.COVER.jpg file exists
    if [[ ! -e "$directory/$prefix.RAW-01.MP.COVER.jpg" && ! -e "$directory/$prefix.RAW-01.COVER.jpg" ]]; then
        if $delete; then
            # Delete the file and increment the deleted count
            rm "$dng_file"
            ((deleted_count++))
        else
            # Just print the file that would be deleted
            echo "$dng_file"
        fi
    fi
done

# Print the count of deleted files if deletion occurred
if $delete; then
    echo "$deleted_count files were deleted."
fi
