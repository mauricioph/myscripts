#!/usr/bin/env python
import sys
import os
import subprocess
import datetime
import shutil

"""
Rules for Trashinfo files to work
The format of trashinfo is similar to the format of a desktop entry file, as described in the Desktop Entry Specification.
Its first line must be [Trash Info]. It also must have two lines that are key/value pairs as described in the Desktop Entry Specification:
The key “Path” contains the original location of the file/directory, as either an absolute pathname (starting with the slash character “/”) or a relative pathname (starting with any other character). 
A relative pathname is to be from the directory in which the trash directory resides (for example, from $XDG_DATA_HOME for the “home trash” directory); it MUST not include a “..” directory, and for files not “under” that directory, absolute pathnames must be used. 
The system SHOULD support absolute pathnames only in the “home trash” directory, not in the directories under $topdir.
The value type for this key is “string”; it SHOULD store the file name as the sequence of bytes produced by the file system, with characters escaped as in URLs (as defined by RFC 2396, section 2). The key “DeletionDate” contains the date and time when the file/directory was trashed. 
The date and time are to be in the YYYY-MM-DDThh:mm:ss format (see RFC 3339). The time zone should be the user's (or filesystem's) local time. The value type for this key is “string”.
"""
# First get the file to be deleted
if len(sys.argv) == 2:
    filename = sys.argv[1]
else:
    print ("Usage: trash.py filename")
    exit(1)

# Check if the file exist or it is creation of a fertile mind
if os.path.exists(filename):
    print ("Trashing the file/folder...")
else:
    print ("The file does not exist any more.\nHave it been deleted already?")
    exit(1)

# Create file info file
casa = os.getenv('HOME')+"/.local/share/Trash"
locfile = os.path.realpath(filename)
now = datetime.datetime.now()
date = now.strftime("%Y%m%dT%H:%M:%S")

if os.path.exists(casa+"/files"):
    print ("files folder ready")
else:
    subprocess.call("mkdir -p %s/files" %(casa), shell=True)
    subprocess.call("mkdir -p %s/info" %(casa),shell=True)

if os.path.isfile(filename):
    arq = subprocess.check_output("basename \"%s\"" %(filename), shell=True)
    arq = arq.decode("utf-8").rstrip("\n")
    print (arq)
elif os.path.isdir(filename):
    arq = subprocess.check_output("basename \"%s\"" %(filename), shell=True)
    arq = arq.decode("utf-8").rstrip("\n")
    print (arq)

with open('%s/info/%s.trashinfo' % (casa,arq), 'w') as f:
    f.write("[Trash Info]\n")
    f.write("Path=%s\n" % locfile)
    f.write("DeletionDate=%s\n" % date)



# Move the file to the trash
shutil.move(locfile, casa+"/files/"+arq)

