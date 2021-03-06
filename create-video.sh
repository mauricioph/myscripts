#!/bin/bash
# Create a video from an audio file, it will use an image as background and add the wave form animation based on the 
# audio detection from ffmpeg.
# expected output https://www.youtube.com/watch?v=1htjI7YSNZo&t=80s
image="${2}"
input="${1}"
output="${input}.mp4"
array[0]="blue"
array[1]="red"
array[2]="brown"
array[3]="yellow"
array[4]="green"
array[5]="orange"
array[6]="pink"
array[7]="purple"
array[8]="grey"

convert "${image}" -resize 1920x1080 -density 300 "${image}2.png"
size=${#array[@]}
index=$(($RANDOM % $size))
echo ${array[${index}]}
color=${array[${index}]}

ffmpeg -i "${input}" -loop 1 -i "${image}" -filter_complex "[0:a]showwaves=mode=cline:size=1920x180:colors=${color},colorkey=0x000000,format=yuva420p[v];[1:v][v]overlay=0:890[outv]" -map "[outv]" -pix_fmt yuv420p -s 1920x1080 -threads 0 -map 0:a -c:v libx264 -maxrate 4M -bufsize 7M -preset ultrafast -profile:v:0 high -level:v:0 4.1 -crf 23 -x264opts:0 subme=0:me_range=4:rc_lookahead=10:me=dia:no_chroma_me:8x8dct=0:partitions=none -g:v:0 72 -keyint_min:v:0 72 -sc_threshold:v:0 0 -c:a aac -b:a 128k -map 0:a -shortest -y "${output}"
