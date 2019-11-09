#!/bin/bash
if [ -z ${1} ]
	then echo "Usage: $0 audio-file"
fi

audio-file = "${1}"

b=$(cat ${audio-file} | wc -l)
a=0
while [ "${a}" != "${b}" ]
 do ffmpeg -i "${audio-file}" -ss ${a} -t 10 -c copy -y /tmp/transcript-${a}.mp3
 cp /tmp/transcript-${a}.mp3 transcript.mp3
 python3 transcribe.py
 let a=$(($a + 10))
done

leng=$(cat treino.txt | wc -l)
for i in {1..297}
do translate -d pt -s en "$(cat treino.txt | sed -n ${i}p)" >> traducao.txt
done
