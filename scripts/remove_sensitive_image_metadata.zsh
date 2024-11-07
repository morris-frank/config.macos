#!/bin/zsh

for file in "$@"
do
    /usr/local/bin/exiftool -gps:all= -time:all= -createdate= -modifydate= -datetimeoriginal= -filemodifydate= "$file" -o "${file:r}.stripped.${file:e}"
done
