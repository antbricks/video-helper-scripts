#!/bin/bash

for myTitle in {01..72}
do
        HandBrakeCLI -i '/home/kevin/nas/p2p/transmission/Virtual Sex With Kira Kener/Virtual Sex With Kira Kener .iso'  -o "/home/kevin/Desktop/vskk/vskk${myTitle}_1.mp4" -e x264 -q 20 -B 160 -t "$myTitle" --angle 1 
        HandBrakeCLI -i '/home/kevin/nas/p2p/transmission/Virtual Sex With Kira Kener/Virtual Sex With Kira Kener .iso'  -o "/home/kevin/Desktop/vskk/vskk${myTitle}_2.mp4" -e x264 -q 20 -B 160 -t "$myTitle" --angle 2 
done



