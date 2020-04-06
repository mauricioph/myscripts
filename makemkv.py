#!/usr/bin/env python

import subprocess
import sys
import os.path
from os import path

# Check Dependencies
def is_tool(name):
    from shutil import which
    return which(name) is not None

pgm = ['ffmpeg', 'lsdvd', 'mplayer', 'mkvmerge']

for programs in pgm:
    checkpgm = is_tool(programs)
    print ('The program %s is installed.' %(programs))
    if checkpgm == False:
        if programs == 'mkvmerge':
            programs == 'mkvtoolnix'
        subprocess.call('sudo apt install %s' %(programs), shell=True)

# Check if the track was passed as an argumment, if not it will get the longest track
if len(sys.argv) == 2:
    track = sys.argv[1]
else:
    track = str(subprocess.check_output("lsdvd | grep Longest | cut -d "":"" -f 2 | awk '{print $1}'", shell=True))
    track = track[2:-3]

# Create the folder into Videos folder if it does not exit
disctitle = str(subprocess.check_output("lsdvd | grep Disc | cut -d "":"" -f 2 | awk '{print $1}'", shell=True))
disctitle = disctitle[2:-3]
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
    subprocess.call("mplayer dvd://%s -vc null -dumpstream -dumpfile %s" %(track, output), shell=True)
else:
    print ("The output file %s already exists, please delete it. Not overwritting" %(output))
    exit(1)

if not path.exists(finalfile):
    subprocess.call("mkvmerge -o %s --chapters /tmp/chapter.txt %s" %(finalfile, output), shell=True)

# This should check if the previous if worked, do not merge as if and elif it will not work.
# This if needs to run after the other if and not together.
if path.exists(finalfile):
    subprocess.call("rm -f "+output, shell=True)
    subprocess.call("rm -f /tmp/chapter.txt", shell=True)
    print ("File saved at "+finalfile)

subprocess.call("eject", shell=True)
