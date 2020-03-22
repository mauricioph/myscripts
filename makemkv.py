#!/bin/env python

import subprocess
import os.path
from os import path

# Check Dependencies
def is_tool(name):
    from shutil import which
    return which(name) is not None

ffmpeg = is_tool('ffmpeg')
lsdvd = is_tool('lsdvd')
mplayer = is_tool('mplayer')
mkvtoolnix = is_tool('mkvtoolnix-gui')

if ffmpeg is False:
    subprocess.call('sudo apt install ffmpeg', shell=True)

if lsdvd is False:
    subprocess.call('sudo apt install lsdvd', shell=True)

if mplayer is False:
    subprocess.call('sudo apt install mplayer', shell=True)

if mkvtoolnix is False:
    subprocess.call('sudo apt install mkvtoolnix-gui', shell=True)

# Check if the track was passed as an argumment, if not it will get the longest track
# I am stucked here.

# Create the folder into Videos folder if it does not exit
disctitle = str(subprocess.check_output("lsdvd | grep Disc | cut -d "":"" -f 2 | awk '{print $1}'", shell=True))
disctitle = disctitle[2:-3]
track = str(subprocess.check_output("lsdvd | grep Longest | cut -d "":"" -f 2 | awk '{print $1}'", shell=True))
track = track[2:-3]
folder = str.format(os.path.expanduser(os.getenv('HOME'))+"/Videos/"+disctitle)
output = str.format(folder+"/title_t"+track+".vob")
finalfile = output.replace(".vob", ".mkv")

if not path.exists(folder):
  subprocess.call('mkdir -p '+folder, shell=True)


# Extract the chapters from the DVD and save the file in te right format

capitulos = subprocess.check_output("mplayer -identify -frames 1 dvd://"+track+" 2>/dev/null | grep CHAPTERS: | sed 's/CHAPTERS: //' | sed 's/,/ /g'", shell=True)
capitulos = capitulos.decode('utf-8')
capitulos = capitulos.split(" ")
tot = len(capitulos)
j2=1
for i in  range(tot - 1):
 j2 = str(j2)
 with open('/tmp/chapter.txt', 'a') as f:
    f.writelines("CHAPTER"+j2+"="+capitulos[i]+"\n")
    f.writelines("CHAPTER"+j2+"NAME=Chapter "+j2+"\n")
 j2 = int(j2)
 j2 = j2 + 1

# Do the ripping of the file in vob first and then add the chapters on the mkv file
if not path.exists(output):
    subprocess.call("mplayer dvd://"+track+" -vc null -dumpstream -dumpfile "+output, shell=True)
else:
    print ("The output file "+output+" already exists, delete it. Not overwritting")

if not path.exists(finalfile):
    subprocess.call("mkvmerge -o "+finalfile+" --chapters /tmp/chapter.txt "+output, shell=True)

if path.exists(finalfile):
    subprocess.call("rm -f "+output, shell=True)
    subprocess.call("rm -f /tmp/chapter.txt", shell=True)
    print ("File saved at "+finalfile)