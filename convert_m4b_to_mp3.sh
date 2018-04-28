#!/bin/bash

mkdir -p "$2"

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for i in `find "$1" -type f -iname "*.m4b" -print`; do
    echo $i
    NAME=`basename -s .m4b $i`
    echo "doing '$NAME'"
    faad --stdio $i | lame --preset standard - "$2/${NAME}.mp3"
done

IFS=$SAVEIFS
