#!/bin/bash
mes=$(date +%B)
ans="/home/mauricio/Podcasts/My Own/pt/${mes}"

if [ -f /tmp/urls ]
        then echo "There is a list of links here /tmp/usrls"
        else echo "updating the list, you can get the links at /tmp/urls"
                for i in $(curl https://soundcloud.com/bispomacedo | grep url | grep itemprop | cut -d "=" -f 4 | cut -d ">" -f 1)
                        do echo https://soundcloud.com$(echo ${i} | sed 's/"//g') >> /tmp/urls
                done
fi
	if [ ! -d "${ans}" ]
		then mkdir -p "${ans}"
	fi

echo "Enter the link"
read link
echo "Enter the name"
read dest

wget "${link}" -O "${ans}/${dest}.mp3" 

		if [ "${1}" = "-p" ]
			then vlc "${ans}/${dest}.mp3"
		fi
