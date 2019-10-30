import subprocess
import random

color = ['white', 'blue', 'red', 'green', 'orange']
my_color = random.choice(color)
print(my_color)

in_movie = input("Enter an audio file: ")
in_photo = input("Enter a photo file: ")
out_movie = input("Enter the output video: ")
in_foto = str(in_photo) + "-converted.png"

def imagemagik():
 subprocess.call('convert '+ str(in_photo) + ' -resize 1920x1080 ' + str(in_foto), shell=True)

def ffmpeg():
 subprocess.call('ffmpeg -i ' + str(in_movie) + ' -i ' + str(in_foto) + ' -filter_complex "[0:a]showwaves=mode=cline:size=1920x180:colors="' + str(my_color) + '",format=yuv420p[v];[1:v][v]overlay=0:890[outv]" -map [outv] -pix_fmt yuv420p -s 1920x1080 -threads 0 -c:v libx264 -maxrate 4M -bufsize 7M -preset ultrafast -profile:v:0 high -level:v:0 4.1 -crf 23 -x264opts:0 subme=0:me_range=4:rc_lookahead=10:me=dia:no_chroma_me:8x8dct=0:partitions=none -g:v:0 72 -keyint_min:v:0 72 -sc_threshold:v:0 0 -c:a aac -b:a 128k -map 0:a -shortest -y '+str(out_movie), shell=True)

imagemagik()
ffmpeg()
