#!/bin/sh -e

# i3 folder
i3folder="$HOME/.config/i3/"
# Icon
icon="${i3folder}/icon.png"
# Take a screenshot
scrot ${i3folder}/screen_locked.png

# Pixellate it 10x and write the enter the password phrase.
convert -resize 10% ${i3folder}/screen_locked.png ${i3folder}/screen_locked2.png
convert -resize 1000% ${i3folder}/screen_locked2.png ${i3folder}/screen_locked.png
rm ${i3folder}/screen_locked2.png
convert ${i3folder}/screen_locked.png  "$icon" -gravity center -composite -font Helvetica -pointsize 32 -draw "gravity South fill grey text 3,14 'Enter the password' fill blue  text 1,14 'Enter the password'" ${i3folder}/screen_locked.png

# Lock screen displaying this image.
i3lock -i ${i3folder}/screen_locked.png

# Turn the screen off after a delay.
sleep 120; pgrep i3lock && xset dpms force off
