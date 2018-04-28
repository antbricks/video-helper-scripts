#!/bin/bash

for myTitle in {01..49}
do
        HandBrakeCLI -i /home/kevin/Desktop/vsth.iso -o "/home/kevin/Desktop/vsth/vsth${myTitle}_1.mp4" -e x264 -q 20 -B 160 -t "$myTitle" --angle 1 
        HandBrakeCLI -i /home/kevin/Desktop/vsth.iso -o "/home/kevin/Desktop/vsth/vsth${myTitle}_2.mp4" -e x264 -q 20 -B 160 -t "$myTitle" --angle 2 
done



