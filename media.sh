#!/bin/bash

usage(){
echo "Media script check the requirements and best bitrate for a video"
echo "$0 video"
echo "Use -d for debugging"
echo ""
exit 1
}


[ -z ${1} ] && usage

[ ! -d "${HOME}/.config/gauge" ] && mkdir -p "${HOME}/.config/gauge"
entrada=$(realpath "${1}")
filme=$(basename "${entrada}" | tr -d '\ \-\_')
tempo=$(mktemp -d ${HOME}/.config/gauge/${filme}.XXXXX)
ffprobe "${entrada}" -show_streams 2>&1 > "${tempo}/stream.txt"

altura=$(cat "${tempo}/stream.txt" | grep "^height=" | cut -d "=" -f 2)
largura=$(cat "${tempo}/stream.txt" | grep "^width=" | cut -d "=" -f 2)
quadro=$(cat "${tempo}/stream.txt" | grep "avg_frame_rate" | cut -d "=" -f 2 | cut -d "/" -f 1 | sort -r | sed -n 1p)
[ "${quadro}" -gt 100 ] && quadro=$(echo $((${quadro} / 1001)) | cut -d "." -f 1)


actionfactor=$(( ${altura} * ${largura} * ${quadro} * 8 / 1007 / 100))
echo "The video bitrate should be ${actionfactor}kb/s"

echo "Do you want to convert now?"
read media
case ${media} in
	y) /usr/bin/ffmpeg -vaapi_device /dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -i "${entrada}" -threads 8 -vf 'format=nv12|vaapi,hwupload'  -profile:v high -force_key_frames:0 "expr:gte(t,0+n_forced*3)" -c:v h264_vaapi -maxrate 7M -bufsize 14M -b:v ${actionfactor}k -g:v:0 75 -keyint_min:v:0 75 -sc_threshold:v:0 0 -level:v 41 -c:a eac3 -b:a 192k -movflags faststart -map 0:0 -map 0:1 -map -0:s -y "/tmp/${filme}-XXXX.mp4"
 	;;
	*) echo "Not converting"
	;;
esac

debuging(){
echo "Entrada = ${entrada}"
echo "Filme = ${filme}"
echo "Tempo = ${tempo}"
echo "Altura = ${altura}"
echo "Largura = ${largura}"
echo "Quadro = ${quadro}"
echo "Actionfactor = ${actionfactor}"
}

[ "${1}" == "-d" ] && debuging || [ "${2}" == "-d" ] && debuging
