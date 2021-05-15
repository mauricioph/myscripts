#!/bin/bash
# Script to put together a radio programme.
# Though it is something I use it for my own radio programme, it might help you
# few free to use it. GPL 

# Set folder structure
entrada="$(realpath "${1}")"
headspasta="/home/mauricio/Radio/Heads"
radiopasta="/home/mauricio/Radio"

# Audio path that are fixed
intro="${headspasta}/Intro_1-4f58073c4c777bb02fead10ae64ade86.flac"
back="${headspasta}/You_are_Listening-ce538b272b3ddf2b7832aae4bb1761bf.flac"
test_intro="${headspasta}/Testimony_intro-0fe9203487c62461faa4864181e4d946.flac"
ending="${headspasta}/Ending-35d976a981592b1a9a31727f3a480bfb.flac"

# Audio path that are ramdon
testimony_folder="${radiopasta}/Testimony"
song_folder="${radiopasta}/Songs"
advert_folder="${radiopasta}/Adverts"
fakenews_folder="${radiopasta}/FakeNews"

# Organise program lab and split the recording on silence above 3 seconds
pgm_title="$(basename "${entrada}" | cut -c 5- | cut -d "." -f 1)"
number=$(basename "${entrada}" | cut -d "-" -f 1)
finale="WOF-${number}-${pgm_title}.flac"
echo "processing program ${finale}"
[[ ! -d "/tmp/radio/${number}" ]] && mkdir "/tmp/radio/${number}" -p
cd "/tmp/radio/${number}"

echo "cutting ${number} in parts"
sox "${entrada}" "${number}_.flac" silence 1 0.5 0.1% 1 3.0 0.1% : newfile : restart
parts=$(ls ${number}_*.flac | wc -l)
echo "${number} are ${parts} pieces of audio"

# Sort songs, testimonies and adverts
function sortsong(){
	musica="$(find ${song_folder} -iname "*.flac" | shuf | sed -n 1p)"
	musicaa="4800/$( basename "${musica}" )"
	sox "${musica}" -r 48000 -c 2 "${musicaa}"
	echo "${musicaa}"
}

function sortadvert(){
	adv=$(find ${advert_folder} -iname "*.flac" | shuf | sed -n 1p)
	adva="4800/$( basename "${adv}" )"
	sox "${adv}" "${adva}" rate 48000
	echo "${adva}"
}

function sortfakenews(){
	fakenews=$(find ${fakenews_folder} -iname "*.flac" | shuf | sed -n 1p)
	fakenewsa="4800/$( basename "${fakenews}" )"
	sox "${fakenews}" "${fakenewsa}" rate 48000
	echo "${fakenewsa}"
}

function sorttestimony(){
	testimonio=$(find ${testimony_folder} -iname "*.flac" | shuf | sed -n 1p)
	testimonioa="4800/$( basename "${testimonio}" )"
	sox "${testimonio}" "${testimonioa}" rate 48000
	echo "${testimonioa}"
}

function sortrecording(){
	for i in /tmp/radio/${number}/${number}_*.flac
	do sox "${i}" -r 48000 -c 2 "4800/$(basename "${i}")"
	parte="/tmp/radio/${number}/4800/$(basename "${i}")"
	echo "${parte}"
	[[ -f "${parte}" ]] && rm "${i}"
	done
}

# convert all the audio for 1 single sample rate
[[ ! -d "/tmp/radio/${number}/4800" ]] && mkdir "/tmp/radio/${number}/4800"
for audio in [0-9][0-9][0-9]_*.flac
	do sox "${audio}" "4800/${audio}" rate 48000
	done

sortsong
echo "Preparing Music ${musica}"
songfile=$( sorttestimony )
echo "This is the song ${songfile}"
echo "Preparing Testimony ${testimonio}" 
sortadvert
echo "Preparing Advert ${adv}"
sortfakenews
echo "Preparing FakeNews ${fakenews}"
sortrecording
echo "Preparing Recording ${number}"

# Join all the pieces

case "${parts}" in
	1) echo "Found a single audio"
	songfile=$( sortsong )
	advert1=$( sortadvert )
	testimonio1=$( sorttestimony )
	testimonio2=$( sorttestimony )
	reca="4800/${number}_001.flac"
	sox "${intro}" "${reca}" "${test_intro}" "${testimonio}" "${songfile}" "${advert1}" "${fakenews}" "${ending}" "${finale}"
	echo -e "${intro} \n${number}_001.flac \n${test_intro} \n${testimonio} \n${song} \n${advert1} \n${fakenews} \n${ending}" >> "${finale}.log" 
	;;
	2) echo "Found two audios"
	testimonio1=$( sorttestimony )
	testimonio2=$( sorttestimony )
	advert1=$( sortadvert )
	songfile=$( sortsong )
	reca="4800/${number}_001.flac"
	recb="4800/${number}_002.flac"
	sox "${intro}" "${reca}" "${test_intro}" "${testimonio1}" "${songfile}" "${back}" "${recb}" "${test_intro}" "${testimonio2}" "${ending}"  "${finale}"
	echo -e "${intro} \n${number}_001.flac \n${test_intro} \n${testimonio1} \n${songfile} \n${back} \n${number}_002.flac \n${test_intro} \n${testimonio2} \n${ending}" >> "${finale}.log"
	;;
	3) echo "3 parts"
	testimonio1=$( sorttestimony )
	testimonio2=$( sorttestimony )
	testimonio3=$( sorttestimony )
	reca="4800/${number}_001.flac"
	recb="4800/${number}_002.flac"
	recc="4800/${number}_003.flac"
	songfile=$( sortsong )
	advert1=$( sortadvert )
	sox "${intro}" "${reca}" "${test_intro}" "${testimonio1}" "${songfile}" "${back}" "${recb}" "${test_intro}" "${testimonio2}" "${back}" "${recc}" "${advert1}" "${test_intro}" "${testimonio3}" "${ending}"  "${finale}"
	echo -e "${intro} \n${number}_001.flac \n${test_intro} \n${testimonio1} \n${song} \n${back} \n${number}_002.flac \n${test_intro} \n${testimonio2} \n${back} \n${number}_003.flac \n${test_intro} \n${testimonio3} \n${ending}" >> "${finale}.log"
	;;
	*) echo "Something wrong, there are more than 3 parts of the audio, please check."
	;;
esac
