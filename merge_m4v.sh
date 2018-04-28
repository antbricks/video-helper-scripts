#!/bin/bash
 
##################################################################
# mergeM4V.sh
# Merges multiple mp4 files
#
# USAGE: mergeM4V.sh -d "dir1 dir2"
#
# OUTPUT: final.mp4 (override this with -o new_target_name.mp4)
#
# The tracks (audio and video) are processed separately,
# if you want to avoid this, use -i option to ignore such
# processing.
##################################################################
 
DIRS="."
OFILE=""
TARGET="final.mp4"
USE_PARAMS=1
 
while getopts "d:o:i" opt; do
    case $opt in
        d)
            DIRS=$OPTARG
        ;;
 
        o)
            TARGET=$OPTARG
        ;;
 
        i)
            USE_PARAMS=0
        ;;
 
        *)
            echo "USAGE: $0 -d dir_list [-o output_file] [-i]"
            exit 1
        ;;
    esac
done
 
MP4BOX_PARAMS=""
PARAMS_1="#1:fps=23.976"
PARAMS_2="#2"
 
MP4BOX_OPT=""
 
first=0
scale=4
page_size=10
 
listing=""
for dir in $DIRS; do
    listing="$listing $dir/*.mp4"
done
 
# convert to an array for easy access
count=1
for item in $listing; do
    array_listing[$count]=$item
    count=$((count + 1))
done
 
page_size=10
total_files=`echo $listing | wc -w`
page=1;
pages=$(($total_files / page_size))
last_items=$(($total_files % page_size))
 
# Work on the array
index=1
 
while [ $page -le $pages ]; do
    count=1
    mp4box_args=""
    while [ $count -le $page_size ]; do
        if [ $USE_PARAMS == 1 ]; then
            mp4box_args="$mp4box_args -cat ${array_listing[$index]}$PARAMS_1 -cat ${array_listing[$index]}$PARAMS_2"
        else
            mp4box_args="$mp4box_args -cat ${array_listing[$index]}"
        fi
 
        count=$((count + 1))
        index=$((index + 1))
    done
 
    OFILE="ofile_${page}.mp4"
    MP4Box $MP4BOX_PARAMS $mp4box_args -new $OFILE
    page=$((page + 1))
done
 
if [ $last_items -gt 0 ]; then
    count=1
    OFILE="ofile_${page}.mp4"
    mp4box_args=""
 
    while [ $count -le $last_items ]; do
        if [ $USE_PARAMS == 1 ]; then
            mp4box_args="$mp4box_args -cat ${array_listing[$index]}$PARAMS_1 -cat ${array_listing[$index]}$PARAMS_2"
        else
            mp4box_args="$mp4box_args -cat ${array_listing[$index]}"
        fi
        count=$((count + 1))
        index=$((index + 1))
    done
 
    MP4Box $MP4BOX_PARAMS $mp4box_args -new $OFILE
fi
 
mp4box_args=""
for ofile in `ls ofile*`; do
    if [ $USE_PARAMS == 1 ]; then
        mp4box_args="$mp4box_args -cat $ofile$PARAMS_1 -cat $ofile$PARAMS_2"
    else
        mp4box_args="$mp4box_args -cat $ofile"
    fi
done
 
MP4Box $MP4BOX_PARAMS $mp4box_args -new $TARGET
rm ofile*.mp4
 
exit 0
