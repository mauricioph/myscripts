#!/bin/bash

IN=$1
THRESH=$2
DURATION=$3

function usando(){
echo -e "Usage: $0 IN THRESHOLD DURATION \nIN - the file path to the video I want to analyze.
THRESH - the volume threshold the filter uses to determine what counts as silence.
DURATION - the length of time in seconds the audio needs to stay below the threshold to count as a section of silence"
}

[ -z "$1" ] && usando || ffmpeg -hide_banner -vn -i $IN -af silencedetect=n=-50dB:d=1  -f null - 2>&1 | grep "silence_end" | awk '{print $5 " " $8}' > silence.txt

