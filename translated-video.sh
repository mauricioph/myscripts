#!/bin/bash

entrada="${1}"
audio="${2}"
saida="/tmp/$(basename "${entrada}" | rev | cut -d "." -f 2-15 | rev).mp4"

[[ -z "${entrada}" ]] && echo "Usage: $0 video.port audio.eng" && exit 1

echo "Test or doit?"
read fazer

case ${fazer} in
     test) ffmpeg -i "${entrada}" -i "${audio}" -loop 1 -c:v libx264 -filter_complex "[0:a]volume=0.2[por];[1:a]volume=2.0[eng];[por][eng]amix[audio]" -map 0:v -map "[audio]" -shortest -t 10 -y "${saida}"
	;;
	doit) ffmpeg -i "${entrada}" -i "${audio}" -loop 1 -c:v libx264 -filter_complex "[0:a]volume=0.2[por];[1:a]volume=2.0[eng];[por][eng]amix[audio]" -map 0:v -map "[audio]" -shortest -y "${saida}"

	;;
	*) echo "Please write test or doit"
	;;
esac
