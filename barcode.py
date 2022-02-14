#!/usr/bin/env python
import sys
import os
import subprocess
import names
import shutil
from os import path

# Check if filename was passed as argumment
if len(sys.argv) == 2:
    filename = sys.argv[1]
else:
    print ("Usage: barcode.py filename")
    exit(1)

# Check if the file exist or it is creation of a fertile mind
if os.path.exists(filename):
    print ("It does exist")
else:
    print ("It does not exist.")
    exit(1)

# Function to do after tagging the file
def worked():
    print ("Tagging successfull!\nOverwritting the original file. Please wait.\n")
    if video.endswith('.mp4'):
        shutil.move(output, video)
    else:
        video2 = video.replace('.mkv', '.mp4')
        shutil.move(output, video2)
        os.remove(video)
    print ("Great!\nAll done.\n")

# Check if the file is either mp4 or mkv
video = os.path.realpath(filename)
if video.endswith('.mp4'):
    print ("It is a mp4")
elif video.endswith('.mkv'):
    print ("It is a mkv"):
else:
    print ("Cannot tag files that are not mkv or mp4")
    exit(1)

# Set the variables
output= "/tmp/%s.mp4" % names.get_first_name(gender='female')
print (output)
title = input("What is the movie name?\n")
year = input("What year was it released?\n")
barcode = input("What is the barcode?\n")

# Tag the file
subprocess.call("ffmpeg -i %s -c copy -metadata title=%s -metadata comment=%s -metadata year=%s -metadata copyright=%s -map 0:v -map 0:a -y %s" % ( video, title, title, year, barcode, output), shell=True)

# If successfull call the ending to replace the original with the tagged.
if os.path.exists(output):
    worked()
