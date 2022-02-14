#!/bin/bash
AC=$(which ffmpeg)
DC=$(which dvdauthor)
DD=$(which dd)
GC=$(which genisoimage)
MD5=$(which md5sum)
WC=$(which growisofs)
ent=$1
TEM=/tmp
# 18619 ffmpeg -i /home/mauricio/Videos/movie/movies/movie_5.mpg -i /home/mauricio/Videos/movie/movies/movie_5.mpg -map 1:1 -vf scale=720:480 -y -target ntsc-dvd -sn -g 12 -bf 2 -strict 1 -ac 2 -aspect 1.3333333333333333 -s 720x480 -trellis 1 -mbd 2 -b:a 224k -b:v 9000k /media/mauricio/27884d70-5edd-4d64-be22-9d87e4e478d7/movie/movies/movie_5.mpg

if [ -z "${ent}" ]
then echo "Usage: $0 [video-file]"
exit 1
fi 
echo "Converting ${ent}"
${AC} -i "${ent}" -target ntsc-dvd ${TEM}/video.mpg >> ${TEM}/dvd.log
export VIDEO_FORMAT=NTSC
cd  ${TEM}
${DC} -o ${TEM}/dvd/ -t ${TEM}/video.mpg >> ${TEM}/dvd.log
${DC} -o ${TEM}/dvd/ -T  >> ${TEM}/dvd.log
${GC} -dvd-video -o ${TEM}/dvd.iso ${TEM}/dvd/ >> ${TEM}/dvd.log
${WC} -dvd-compat -Z /dev/sr0=${TEM}/dvd.iso >> ${TEM}/dvd.log

sec=60
while [ ${sec} != 0 ]
do echo "Insert the dvd back in the tray please"
echo "Time left ${sec}"
let sec=$((${sec} - 1))
if [ ${sec} -le 50 ]
then echo "Do it quickly, the mac dvd driver is very slow to read the dvd"
fi
sleep 1
clear
done

blocks=$(expr $(ls -l dvd.iso | awk '{print $5}') / 2048)
${DD} if=/dev/sr0 bs=2048 count=$blocks | ${MD5}
${MD5} ${TEM}/dvd.iso

rm -rf ${TEM}/dvd* ${TEM}/video.mpg
