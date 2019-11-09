#!/bin/bash
if [ -z ${1} ]
	then echo "Usage: $0 audio-file"
fi

audio-file = "${1}"

b=$(cat ${audio-file} | wc -l)
a=0
while [ "${a}" != "${b}" ]
 do ffmpeg -i "${audio-file}" -ss ${a} -t 10 -c copy -y /tmp/transcript-${a}.mp3
 cp /tmp/transcript-${a}.mp3 /tmp/transcript.mp3
 python3 /usr/local/bin/transcribe.py
 let a=$(($a + 10))
done

leng=$(cat /tmp/treino.txt | wc -l)
a=1
while [ "${a}" != "${leng}" ]
do translate -d pt -s en "$(cat /tmp/treino.txt | sed -n ${a}p)" >> /tmp/traducao.txt
let a=$(($a + 1))
done
