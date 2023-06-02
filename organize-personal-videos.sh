#!/bin/bash

aqui="$(pwd)"
[[ "${aqui}" = "${HOME}" ]] && echo "It is not secure to run this script in the root of the home folder, please run inside a personal videos folder." && exit 1
organiza(){

for i in *.mp4;

do 

	year=$(exiftool "${i}" | grep "^Create Date" | cut -d \: -f 2 | awk '{print $1}');
	month=$(exiftool "${i}" | grep "^Create Date" | cut -d \: -f 3 | awk '{print $1}');
	[[ ! -d ${year} ]] && mkdir ${year};
	[[ ! -d ${year}/${month} ]] && mkdir -p ${year}/${month};
	echo "moving ${i} to ${year}/${month}";
	mv "${i}" "${year}/${month}";
done

}

echo "You are about to restructure the videos inside this folder ${aqui} are you shure this is what you want to do?"
read segue
case "${segue}" in 
	y) organiza
		;;
	yes) organiza
		;;
	*) exit 0
		;;
esac


