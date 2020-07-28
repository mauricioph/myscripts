#!/bin/bash
entrada="${1}"
saida="/mnt/ramdisk/$(basename ${entrada})-gpu.mp4"
processor=$(cat /proc/cpuinfo | grep processor | wc -l)
channels=$(mediainfo "${entrada}" | grep channel | cut -d ":" -f 2 | awk '{print $1}')

#case ${channels} in
#	6) /usr/bin/ffmpeg -vaapi_device /dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -i "${entrada}" -threads 8 -vf 'format=nv12|vaapi,hwupload' -c:v h264_vaapi -maxrate 7M -bufsize 14M -b:v 1500k -g:v:0 75 -keyint_min:v:0 75 -sc_threshold:v:0 0 -c:a eac3 -b:a 192k -map 0:v:0 -map 0:a -y "${saida}"
#	# 6) /usr/bin/ffmpeg -i "${entrada}" -map_metadata -1 -map_chapters -1 -threads ${processor} -map 0:0 -map 0:1 -c:v:0 h264_vaapi -vaapi_device /dev/dri/renderD128 -b:v 4M -maxrate 4M -bufsize 7M -profile:v high -level 41 -force_key_frames:0 "expr:gte(t,576+n_forced*3)" -g 75 -keyint_min 75 -sc_threshold 0 -start_at_zero -vsync -1 -c:a:0 eac3 -b:a 192k -max_delay 5000000 -map "[a]" -y "${saida}"
#	;;
#	2) /usr/bin/ffmpeg -vaapi_device /dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -i "${entrada}" -threads 8 -vf 'format=nv12|vaapi,hwupload' -c:v h264_vaapi -maxrate 7M -bufsize 14M -b:v 1500k -g:v:0 75 -keyint_min:v:0 75 -sc_threshold:v:0 0 -c:a eac3 -b:a 192k -filter_complex "[0:a]join=inputs=1:channel_layout=5.1:map=0.0-FL|0.0-FR|0.0-FC|0.0-LFE|0.0-BL|0.0-BR[a]" -map 0:v:0 -map "[a]" -y "${saida}"
#	;;
#	*) echo "Number of channels is neither 6 nor 2"
#	echo "What do you want to do?"
#	;;
#esac

/usr/bin/ffmpeg -vaapi_device /dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -i "${entrada}" -threads 8 -vf 'format=nv12|vaapi,hwupload' -c:v h264_vaapi -maxrate 7M -bufsize 14M -b:v 2500k -g:v:0 75 -keyint_min:v:0 75 -sc_threshold:v:0 0 -level:v 41 -c:a eac3 -b:a 192k -filter_complex "[0:a]join=inputs=1:channel_layout=5.1:map=0.0-FL|0.0-FR|0.0-FC|0.0-LFE|0.0-BL|0.0-BR[a]" -map 0:v:0 -map "[a]" -y "${saida}"


mediainfo "${saida}" 

echo "Shall I move?"
read moveornot
case ${moveornot} in 
	y) mv "${saida}" "${entrada}"
	;;
	n) echo "Getting out"
	;;
	*) echo "Chose either y or n"
	;;
esac

