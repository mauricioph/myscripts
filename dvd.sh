#!/bin/bash
# Create an dvd and burn it from a video.
AC=$(which ffmpeg)
DC=$(which dvdauthor)
DD=$(which dd)
GC=$(which genisoimage)
MD5=$(which md5sum)
WC=$(which growisofs)
ent="${1}"
TEM=/tmp

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
# This is the problem exclusive to Mac computers.
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
