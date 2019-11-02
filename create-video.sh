#!/bin/bash
input="${1}"
output="${input}.mp4"
array[0]="blue"
array[1]="red"
array[2]="white"
array[3]="yellow"
array[4]="green"
array[5]="orange"
array[6]="pink"
array[7]="purple"
array[8]="grey"


size=${#array[@]}
index=$(($RANDOM % $size))
echo ${array[${index}]}
color=${array[${index}]}

ffmpeg -i "${input}" -i 011-6pm.png -filter_complex "[0:a]showwaves=mode=cline:size=1920x180:colors=${color},format=yuv420p[v];[1:v][v]overlay=0:890[outv]" -map [outv] -pix_fmt yuv420p -s 1920x1080 -threads 0 -c:v libx264 -maxrate 4M -bufsize 7M -preset ultrafast -profile:v:0 high -level:v:0 4.1 -crf 23 -x264opts:0 subme=0:me_range=4:rc_lookahead=10:me=dia:no_chroma_me:8x8dct=0:partitions=none -g:v:0 72 -keyint_min:v:0 72 -sc_threshold:v:0 0 -c:a aac -b:a 128k -map 0:a -shortest -y "${output}"
