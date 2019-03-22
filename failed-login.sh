#!/bin/bash
if [ ! -d /tmp/failed-login ]
then mkdir -p /tmp/failed-login
fi
video="movie-$(date +%d-%m-%Y_%H-%M)"
/usr/bin/streamer -t 0:10 -s 1280x720 -o /tmp/failed-login/${video}.avi -f jpeg -d /dev/video0
ffmpeg -i /tmp/failed-login/${video}.avi -c:v libx264 -profile:v high -preset:v ultrafast -c:a aac -strict -2 -y /tmp/failed-login/${video}.mp4
rm -f /tmp/failed-login/${video}.avi
chmod 777 /tmp/failed-login -R