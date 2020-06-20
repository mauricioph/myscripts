#!/usr/bin/env python
from roku import Roku
import subprocess

print (Roku.discover())
roku = Roku('192.168.10.67')
i = 1
app = Roku.active_app
subprocess.call("notify-send Roku Started", shell=True)

while i > 0:
    key = input("Roku is ready enter a key to start\nOr ctrl+c to end, for help press h")
    if key == 'e':
        roku.up()
    elif key == 's':
        roku.left()
    elif key == 'f':
        roku.right()
    elif key == 'd':
        roku.down()
    elif key == 'p':
        roku.select()
    elif key == 'u':
        roku.volume_up()
    elif key == 'i':
        roku.volume_down()
    elif key == 'm':
        roku.volume_mute()
    elif key == ' ':
        roku.play()
    elif key == 'b':
        roku.backspace()
    elif key == 'a':
        roku.home()
    elif key == 'h':
        print ("This are the keys you can use. \ne = up\ns = left\nd = down\nf = right\np = select\nu = vol up\ni = vol down\nm = mute\nspace = play\na = home\nb = backspace \nh = This help.")
