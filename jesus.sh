#!/bin/bash
#
#
# Script to add metadata on Jesus  series
locations="$HOME/.local/share/TelegramDesktop/tdata/tdld/"
cd ${locations}

trsnf(){
for i in /tmp/Jesus-S01x*
do scp "${i}" n40l.local:/mnt/Seagate/plex/Series/Jesus/
done
}

conv(){
ffmpeg -i "${i}" -c:v copy -c:a copy -async 1 -metadata copyright="${year} Record TV" -metadata title="Jesus" -metadata episode_id="${episode_id}" -metadata show="Jesus" -metadata network="Record TV" -metadata year="${year}" -metadata comment="Novela da Rede Record" -y "${saida}"
}

for i in Jesus.*
do "checking file ${i}"
episode_id=$(echo "${i}" | cut -d "." -f 2)
episode_id=$(echo ${episode_id} | sed 's/S01E//g')

	if [ $episode_id -eq $episode_id ]
	then echo "episode checked"
	else echo "${i} is not in the right format for episode detection"
	fi
year=$(date +%Y)
saida="/tmp/Jesus-S01x${episode_id}.mp4"
conv
done
echo "Do you want to transfer the files now?"
read trx;
case $trx in
	y) trsnf
	;;
	yes) trsnf
	;;
	*) echo "finished"
	;;
esac
