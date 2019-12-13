#!/usr/bin/env python
# Getting series on this format Jezabel-S01x080.mp4 convert it to h265.
import os
import random
import subprocess

folder_destination_path = raw_input("Where are the files?\n")
serie = raw_input("What is the serie Name?\n")
season = raw_input("Which season is that?\n")
network = raw_input("Which Network?\n")
year = raw_input("What year?\n")

print ('Checking \nFolder = '+ folder_destination_path + '\nSerie = '+ serie + '\nSeason = ' + season + '\nNetwork = ' + network + '\nYear = '+ year)

def ffmpeg():
 subprocess.call(['ffmpeg -i "'+ new_name + '" -pix_fmt yuv444p10le -s 1920x1080 -threads 2 -c:v libx265 -maxrate 7M -bufsize 14M -preset ultrafast -profile:v:0 main444-10 -level:v:0 4.1 -crf 23 -x265-params subme=0:me_range=4:rc_lookahead=30:me=dia:no_chroma_me:8x8dct=0:partitions=none -g:v:0 72 -keyint_min:v:0 72 -sc_threshold:v:0 0 -metadata title="'+ serie +'" -metadata network="' + network +'" -metadata year="'+ year +'" -metadata comment="'+ serie +' from '+ network +'" -c:a ac3 -b:a 192k -filter_complex "[0:a]join=inputs=1:channel_layout=5.1:map=0.0-FL|0.0-FR|0.0-FC|0.0-LFE|0.0-BL|0.0-BR[a]" -map 0:v:0 -map [a] -y "'+ src + '"'], shell=True)

for x in range(10, 81):
 number = random.randint(1, 500)
 orig = serie +'-S'+ season +'x0'+ str(x) +'.mp4'
 new_name = folder_destination_path + "/" + orig
 print ('new name = ' + new_name)
 src = folder_destination_path + "/" + str(number) + ".mp4"
 print ('sorce = '+ src)
 ffmpeg()
 os.rename(src, new_name)

