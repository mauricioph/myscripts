#!/bin/bash
intro=$(realpath "${1}")
serie="$(echo "${intro}" | cut -d "/" -f 6)"
episode=$(basename "${intro}" | cut -d "-" -f 2 | cut -d "x" -f 2 | cut -d "." -f 1)
[ -z ${episode} ] && echo "Episode undefined"
season="$(echo "${intro}" | cut -d "/" -f 7)"
apikey=4fcaccc6
plot="$(curl -s "http://www.omdbapi.com/?t=${serie}&apikey=${apikey}" | cut -d ":" -f 11 | sed 's/\"\,\"/\n/g' | sed -n 1p | sed 's/\"//g')"
arq=$(basename "${intro}")
ext="${arq##*.}"

echo "${intro}"
echo "${serie}"
echo "${season}"
echo "${episode}"
echo "${plot}"

ffmpeg -i "${intro}" -c copy -metadata title="${serie}" -metadata season="${season}" -metadata episode_id="${episode}" -metadata comment="${plot}" -y "${intro}-fixed.${ext}"
