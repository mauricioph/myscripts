#!/bin/bash
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  

# Variables
mwmfolder="$HOME/.config/mwm"
icon="${mwmfolder}/icon.png"
unlocked="${mwmfolder}/unlocked.jpg"
lockedone="${mwmfolder}/screen_locked1.png"
locked="${mwmfolder}/screen_locked.png"

# Take a screenshot and edit 
scrot ${unlocked}
convert ${unlocked} -blur 0x5 -swirl -360 ${lockedone}
rm ${unlocked}
convert ${lockedone}  "$icon" -gravity center -composite -font Helvetica -pointsize 32 -draw "gravity South fill black text 3,14 'Enter the password' fill blue  text 1,14 'Enter the password'" ${locked}
rm ${lockedone}

# Lock screen displaying this image.
i3lock -i ${locked}

# Turn the screen off after a delay.
sleep 300; pgrep i3lock && xset dpms force off
