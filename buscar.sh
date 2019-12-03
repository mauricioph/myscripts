#!/bin/bash
mes=$(date +%B)
ans="/home/mauricio/Podcasts/My Own/pt/${mes}"

online=$(ip a | grep "192.168"  | cut -d " " -f 6)

if [ -z ${online} ]
then echo "It seems that you are off-line. Please check your connection and try again"
exit 1
fi

echo "The plugin might have an update, do you want to check and install it?"
echo "Not installing an update may stop the download of the audio, however to install you need sudo or admin rights."

if [ -z $1 ]
then read listen
else listen=y
fi

case ${listen} in
	y)
	sudo youtube-dl -U
	;;
	yes)
	sudo youtube-dl -U
	;;
	*)
	echo "if it fails please run again and update the plugin"
	;;
esac

if [ -f /tmp/urls ]
        then echo "The links are here /tmp/urls"
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
	dest=$(echo ${dest} | sed 's/\//\./g')
	orig=$(youtube-dl --get-title "${i}" | cut -d "-" -f 2 | sed 's/\//\./g' | awk '{print $1}')
	saida=$( echo "${ans}/${orig}-${dest}.mp3" | sed 's/\ .mp3/\.mp3/')
		if [ -f "${saida}" ]
			then echo "File ${saida} is ready"
			telegram-send "File ${saida} is ready"
			else youtube-dl "${i}" -o "${saida}"
		fi
		sleep 3;
		clear
	if [ $1 = "-d" ]
		then echo ${dest}
		echo ${orig}
		echo ${saida}
	fi
	clear
	done
}
linkage
