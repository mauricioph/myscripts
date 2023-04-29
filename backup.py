#!/usr/bin/env python
import os
import subprocess

# THIS FILE HAS NOT BEEN TESTED YET, JUST CREATED... NOT SAFE TO DO USE IF YOU DO NOT KNOW WHAT TO EDIT

hardriveuuid = "2ea8b5cd-95e3-42fb-a326-5e7d268fb581"
device = subprocess.check_output("blkid | grep %s | cut -d "" "" -f 1 | sed 's/\://'" %(hardriveuuid), shell=True)
pointmount = subprocess.call("mount | grep %s | cut -d "" "" -f 3" %(device), shell=True)

if not device:
    print ("The device is not connected, aborting backup. Please make sure it is plugged and the cable is working.")
    exit (1)

if not pointmount:
    print ("The hard drive is not mounted yet, mounting it now on /mnt")
    location = subprocess.call("mount | grep /mnt | cut -d "" "" -f 1", shell=True)
    if not location:
        print ("########## ERROR ############\n/mnt is mounted, but it is not your hard drive. umount it first")
        exit (1)

subprocess.call("mount %s /mnt" %(device), shell=True)
pointmount = "/mnt"
print ("rsync -havz --exclude=/mnt --exclude=/dev/ --exclude=/tmp --exclude=/proc --exclude=/sys / "+pointmount)

# subprocess.call("rsync -havz --exclude=/mnt --exclude=/dev/ --exclude=/tmp --exclude=/proc --exclude=/sys / "+pointmount, shell=True)
