#!/bin/bash
#
#
# Script to add metadata on Jesus  series
locations="$HOME/.local/share/TelegramDesktop/tdata/tdld/"
echo "Qual e a serie?"
read serie
echo "Preparando ${serie}"
cd ${locations}

trsnf(){
for i in /tmp/${serie}-S01x*
do scp "${i}" n40l.local.home:/mnt/Seagate/plex/Series/${serie}/
done
}

conv(){
ffmpeg -i "${i}" -c:v copy -c:a copy -async 1 -metadata copyright="${year} Record TV" -metadata title="${serie}" -metadata episode_id="${episode_id}" -metadata show="${serie}" -metadata network="Record TV" -metadata year="${year}" -metadata comment="Novela da Rede Record" -y "${saida}"
}

for i in ${serie}*
do "checking file ${i}"

temundr=$(echo "${i}" | grep _ )
if [ ! -z ${temundr} ]
then mv "${i}" "$(echo "${i}" | sed 's/_/\./g')"
i="$(echo "${i}" | sed 's/_/\./g')"
fi

episode_id=$(echo "${i}" | cut -d "." -f 3)
episode_id=$(echo ${episode_id} | sed 's/S01E//g')

	if [ $episode_id -eq $episode_id ]
	then echo "episode checked"
	else echo "${i} is not in the right format for episode detection"
	fi
year=$(date +%Y)
saida="/tmp/${serie}-S01x${episode_id}.mp4"
conv
# rm "${i}"
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
