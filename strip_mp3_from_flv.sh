#!/bin/bash
IFS_BAK=$IFS
IFS="
"

for TEMPVAR in `ls *.mp4`; do
	NEWFILENAME=`basename "$TEMPVAR" .avi`
	ffmpeg -i "$TEMPVAR" -f mp3 -vn -acodec copy "$NEWFILENAME.mp3"
done

IFS=$IFS_BAK
IFS_BAK=



