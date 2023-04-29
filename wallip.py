#!/usr/bin/python3
import os
import random
import time
from PIL import Image, ImageDraw, ImageFont
import socket
import subprocess
import textwrap
import configparser
import html

# Read the config file
config = configparser.ConfigParser()
config_file = os.path.expanduser('~/.config/wallip.conf')
config.read(config_file)

# config.read(os.path.expanduser('/home/mauricio/.config/wallip.conf'))
# print (config)
# Extract the quote from the config file
quote = html.unescape(config['QUOTE']['text'])

# Set the folder containing the photos
PHOTO_FOLDER = '/usr/share/backgrounds/'

# Set the font and font size for the text
FONT_PATH = '/usr/share/fonts/truetype/open-sans/OpenSans-Bold.ttf'
FONT_SIZE = 48

def set_wallpaper(image_path):
    subprocess.run(["feh", "--bg-scale", image_path])

while True:
    # Get a random photo from the folder
    photo_files = os.listdir(PHOTO_FOLDER)
    photo_path = os.path.join(PHOTO_FOLDER, random.choice(photo_files))

    # Open the photo and resize it
    photo = Image.open(photo_path)
    photo = photo.resize((1920, 1080))

    # Draw the text on the photo
    draw = ImageDraw.Draw(photo)
    font = ImageFont.truetype(FONT_PATH, FONT_SIZE)
    text = "Offline"

    # Check if the computer is online
    try:
        s = socket.create_connection(("www.google.com", 80), 2)
        text = "Online - IP: " + s.getsockname()[0]
    except:
        pass

    text_width, text_height = draw.textsize(text, font)
    # Draw the text with a shadow
    shadow_color = (0, 0, 0)  # black
    shadow_offset = (2, 2)   # 2 pixels to the right and 2 pixels down

    draw.text(((1920 - text_width) / 2 + shadow_offset[0], shadow_offset[1]), text, font=font, fill=shadow_color)
    draw.text(((1920 - text_width) / 2, 0), text, font=font)

    # Draw the second text with a quote
    quote_font = ImageFont.truetype(FONT_PATH, int(FONT_SIZE/2))
    lines = textwrap.wrap(quote, width=int((1920 - 80*2)/quote_font.size))
    lines.reverse()
    y_text = 1080 - 100
    max_height = int(1080/2)
    total_height = 0
    for line in lines:
        width, height = draw.textsize(line, quote_font)
        if total_height + height > max_height:
            break
        total_height += height
        draw.text((1920 - width - 80, y_text), line, font=quote_font, fill=shadow_color)
        draw.text((1920 - width - 78, y_text-2), line, font=quote_font)
        y_text -= height
    
    user_id = str(os.getuid())
    run_path = "/run/user"

    if not os.path.isdir(run_path):
            os.makedirs(run_path)
            try:
                int(user_id)
            except ValueError:
                raise ValueError(f"{user_id} is not a valid user ID")

            path = f"{run_path}/{user_id}"

            if not os.path.isdir(path):
                    os.makedirs(path)

                    print(path)


    # Save the modified photo
    photo.save(f'{run_path}/{user_id}/modified_photo.jpg')

    # Set the modified photo as the wallpaper
    set_wallpaper(f'{run_path}/{user_id}/modified_photo.jpg')

    # Sleep for 1 minute
    time.sleep(60)
