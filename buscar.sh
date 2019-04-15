#!/bin/bash
mes=$(date +%B)
ans="/home/mauricio/Podcasts/My Own/pt/${mes}"

if [ -f /tmp/urls ]
        then echo "The links are here /tmp/usrls"
        else echo "Updating the links at /tmp/urls"
                for i in $(curl https://soundcloud.com/bispomacedo | grep url | grep itemprop | cut -d "=" -f 4 | cut -d ">" -f 1)
                        do echo https://soundcloud.com$(echo ${i} | sed 's/"//g') >> /tmp/urls
                done
fi
	if [ ! -d "${ans}" ]
		then mkdir -p "${ans}"
	fi

function linkage(){
	for i in $(cat /tmp/urls | sed -n 2,10p);
	do dest=$(youtube-dl --get-title "${i}" | cut -d "-" -f 1)
	orig=$(youtube-dl --get-title "${i}" | cut -d "-" -f 2 | sed 's/\//\./g' | awk '{print $1}')
	saida=$( echo "${ans}/${orig}-${dest}.mp3" | sed 's/\ .mp3/\.mp3/')
		if [ -f "${saida}" ]
			then echo "File ${saida} is ready"
			else youtube-dl "${i}" -o "${saida}"
		fi
		sleep 3;
#	clear
	done
}
linkage
