#!/bin/bash
mencoder "$1" -o "$2" -oac mp3lame -lameopts cbr:br=64:mode=3 -srate 16000 -ovc xvid -xvidencopts bitrate=180 -ofps 30000/1001 -vf scale=320:208

