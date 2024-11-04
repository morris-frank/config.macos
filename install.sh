#!/bin/bash

# Define source and destination directories
src_dir="$PWD/bin/"
dest_dir="$HOME/.local/bin/"

# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Loop through all files in the source directory
for file in "$src_dir"*; do
  if [ -f "$file" ]; then
    # Create a soft link in the destination directory
    ln -sf "$file" "$dest_dir"
  fi
done

echo "Soft links created for all files in $src_dir to $dest_dir."
