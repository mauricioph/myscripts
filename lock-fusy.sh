#!/bin/sh -e

# i3 folder
i3folder="$HOME/.config/i3/"
# Icon
icon="${i3folder}/icon.png"
# Take a screenshot
locker=$(mktemp /tmp/.lock.XXXXX.png)
locked=$(basename ${locker})
scrot ${i3folder}/${locked}

# Pixellate it 10x and write the enter the password phrase.
convert -resize 10% ${i3folder}/${locked} ${i3folder}/screen_locked2.png
rm ${i3folder}/screen_locked.png
convert -resize 1000% ${i3folder}/screen_locked2.png ${i3folder}/screen_locked3.png
rm ${i3folder}/screen_locked2.png
convert ${i3folder}/screen_locked3.png  "$icon" -gravity center -composite -font Helvetica -pointsize 32 -draw "gravity South fill grey text 3,14 'Enter the password' fill blue  text 1,14 'Enter the password'" ${i3folder}/screen_locked.png
rm ${i3folder}/screen_locked3.png
rm ${i3folder}/${locked}
rm ${locker}
# Lock screen displaying this image.
i3lock -i ${i3folder}/screen_locked.png

# Turn the screen off after a delay.
sleep 300; pgrep i3lock && xset dpms force off
