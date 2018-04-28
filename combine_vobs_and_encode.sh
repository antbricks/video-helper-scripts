#!/bin/bash

RESULTSIZE=1100
FILESCOUNT=`ls ./*.vob | wc -l`
echo "FILESCOUNT: $FILESCOUNT"

PARTSIZE=$(($RESULTSIZE / $FILESCOUNT))
echo "PARTSIZE: $PARTSIZE"

for VOBFILE in `ls ./*.vob`
    do
        echo "transcoding $VOBFILE..."
        echo "pass 1..."
        PARTNAME=`echo ${VOBFILE/vob/avi}` 
        mencoder $VOBFILE -oac mp3lame -ovc xvid -xvidencopts pass=1 -o /dev/null #2>&1 | grep -o "[0-9]*\%" | awk '{ printf "%s", $0 }'
        echo "pass 2..."
        mencoder $VOBFILE -oac mp3lame -ovc xvid -xvidencopts pass=2:bitrate=-${PARTSIZE}000 -o $PARTNAME #2>&1 | grep -o "[0-9]*\%" | awk '{ printf "%s", $0 }'
        rm ./divx2pass.log
    done
TEMPVAR=`ls ./*-001.vob`
echo "Concatenating the seperate parts..."
FINALNAME=${TEMPVAR::$((${#TEMPVAR}-8))}.avi
FINALNAME=${FINALNAME//_/ }
echo "FINALNAME is $FINALNAME"
mencoder -o "$FINALNAME" -ovc copy -oac copy `ls ./*.avi` #2>&1 | grep -o "[0-9]*\%" | awk '{ printf "%s", $0 }'



