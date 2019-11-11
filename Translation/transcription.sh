#!/bin/bash
if [ -z ${1} ]
	then echo "Usage: $0 audio-file"
fi

# Audio file is passed on command line as argument, total lenght of audio is divided by 10 seconds blocks
# and saved as transcript.mp3 on the /tmp folder, python script is called to write the words on a file

audiofile="${1}"
b=$(($(mp3info -p "%S" ${audiofile}) / 10))
a=0

while [ "${a}" != "${b}" ]
 do ffmpeg -i "${audiofile}" -ss ${a} -t 10 -c copy -y /tmp/transcript-${a}.mp3
 mv /tmp/transcript-${a}.mp3 /tmp/transcript.mp3
 python3 /usr/local/bin/transcribe.py
 let a=$(($a + 10))
done

# Text file with the words is translated to english. Translation is done line by line.
leng=$(cat /tmp/BishopMacedo.txt | wc -l)
a=1
while [ ${a} != ${leng} ]
do translate -d en -s pt "$(cat /tmp/BishopMacedo.txt | sed -n ${a}p)" >> traducao.txt
let a=$(($a + 1))
done
