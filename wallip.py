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
import requests
from bs4 import BeautifulSoup

def update_quote_of_the_day():
    # Send a GET request to the Bible Gateway homepage
    response = requests.get("https://www.biblegateway.com/")

    # Create a BeautifulSoup object to parse the HTML content
    soup = BeautifulSoup(response.text, "html.parser")

    # Find the div with id "verse-text" and extract the text
    verse_text_div = soup.find("div", id="verse-text")
    quote_of_the_day = verse_text_div.text.strip()

    # Update the config file with the new quote
    config = configparser.ConfigParser()
    config_file = "~/.config/wallip.conf"  # Update with the correct path to the config file
    config_file = config_file.replace("~", os.path.expanduser("~"))
    config.read(config_file)
    config.set("QUOTE", "text", quote_of_the_day)
    with open(config_file, "w") as f:
        config.write(f)

# Call the function to update the quote of the day
update_quote_of_the_day()

# Read the config file
config = configparser.ConfigParser()
config_file = os.path.expanduser('~/.config/wallip.conf')
config.read(config_file)

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

    try:
        s = socket.create_connection(("www.google.com", 80), 2)
        text = "Online - IP: " + s.getsockname()[0]
    except:
        pass

    text_bbox = draw.textbbox((0, 0), text, font=font)
    text_width = text_bbox[2] - text_bbox[0]
    text_height = text_bbox[3] - text_bbox[1]

    shadow_color = (0, 0, 0)  # black
    shadow_offset = (2, 2)   # 2 pixels to the right and 2 pixels down

    draw.text(((1920 - text_width) / 2 + shadow_offset[0], shadow_offset[1]), text, font=font, fill=shadow_color)
    draw.text(((1920 - text_width) / 2, 0), text, font=font)

    quote_font = ImageFont.truetype(FONT_PATH, int(FONT_SIZE/2))
    lines = textwrap.wrap(quote, width=int((1920 - 80*2)/quote_font.size))
    lines.reverse()
    y_text = 1080 - 100
    max_height = int(1080/2)
    total_height = 0

    for line in lines:
        text_bbox = draw.textbbox((0, 0), line, font=quote_font)
        width = text_bbox[2] - text_bbox[0]
        height = text_bbox[3] - text_bbox[1]
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

    photo.save(f'{run_path}/{user_id}/modified_photo.jpg')
    set_wallpaper(f'{run_path}/{user_id}/modified_photo.jpg')

    time.sleep(300)

