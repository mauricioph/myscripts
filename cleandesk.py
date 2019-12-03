#!/usr/bin/env python
# Organize the Home folder by getting the files in the Download folder and send it to the folder based on 
# the file type, file extention and date of download.

from watchdog.observers import Observer
import time
from watchdog.events import FileSystemEventHandler
import os 
import json
import shutil
from datetime import datetime
from time import gmtime, strftime

class MyHandler(FileSystemEventHandler):
    def on_modified(self, event):
        for filename in os.listdir(folder_to_track):
            i = 1
            if filename != 'mauricio':
                # try:
                    new_name = filename
                    extension = 'noname'
                    try:
                        extension = str(os.path.splitext(folder_to_track + '/' + filename)[1])
                        path = extensions_folders[extension]
                    except Exception:
                        extension = 'noname'

                    now = datetime.now()
                    year = now.strftime("%Y")
                    month = now.strftime("%m")

                    folder_destination_path = extensions_folders[extension]
                    
                    year_exists = False
                    month_exists = False
                    for folder_name in os.listdir(extensions_folders[extension]):
                        if folder_name == year:
                            folder_destination_path = extensions_folders[extension] + "/" +year
                            year_exists = True
                            for folder_month in os.listdir(folder_destination_path):
                                if month == folder_month:
                                    folder_destination_path = extensions_folders[extension] + "/" + year + "/" + month
                                    month_exists = True
                    if not year_exists:
                        os.mkdir(extensions_folders[extension] + "/" + year)
                        folder_destination_path = extensions_folders[extension] + "/" + year
                    if not month_exists:
                        os.mkdir(folder_destination_path + "/" + month)
                        folder_destination_path = folder_destination_path + "/" + month


                    file_exists = os.path.isfile(folder_destination_path + "/" + new_name)
                    while file_exists:
                        i += 1
                        new_name = os.path.splitext(folder_to_track + '/' + filename)[0] + str(i) + os.path.splitext(folder_to_track + '/' + filename)[1]
                        new_name = new_name.split("/")[4]
                        file_exists = os.path.isfile(folder_destination_path + "/" + new_name)
                    src = folder_to_track + "/" + filename

                    new_name = folder_destination_path + "/" + new_name
                    os.rename(src, new_name)
                # except Exception:
                #     print(filename)
extensions_folders = {
#No name
    'noname' : "/home/mauricio/Other/Uncategorized",
#Audio
    '.aif' : "/home/mauricio/Media/Audio",
    '.cda' : "/home/mauricio/Media/Audio",
    '.mid' : "/home/mauricio/Media/Audio",
    '.midi' : "/home/mauricio/Media/Audio",
    '.mp3' : "/home/mauricio/Media/Audio",
    '.mpa' : "/home/mauricio/Media/Audio",
    '.ogg' : "/home/mauricio/Media/Audio",
    '.wav' : "/home/mauricio/Media/Audio",
    '.wma' : "/home/mauricio/Media/Audio",
    '.wpl' : "/home/mauricio/Media/Audio",
    '.m3u' : "/home/mauricio/Media/Audio",
#Text
    '.txt' : "/home/mauricio/Text/TextFiles",
    '.doc' : "/home/mauricio/Text/Microsoft/Word",
    '.docx' : "/home/mauricio/Text/Microsoft/Word",
    '.odt ' : "/home/mauricio/Text/TextFiles",
    '.pdf': "/home/mauricio/Text/PDF",
    '.rtf': "/home/mauricio/Text/TextFiles",
    '.tex': "/home/mauricio/Text/TextFiles",
    '.wks ': "/home/mauricio/Text/TextFiles",
    '.wps': "/home/mauricio/Text/TextFiles",
    '.wpd': "/home/mauricio/Text/TextFiles",
#Video
    '.3g2': "/home/mauricio/Media/Video",
    '.3gp': "/home/mauricio/Media/Video",
    '.avi': "/home/mauricio/Media/Video",
    '.flv': "/home/mauricio/Media/Video",
    '.h264': "/home/mauricio/Media/Video",
    '.m4v': "/home/mauricio/Media/Video",
    '.mkv': "/home/mauricio/Media/Video",
    '.mov': "/home/mauricio/Media/Video",
    '.mp4': "/home/mauricio/Media/Video",
    '.mpg': "/home/mauricio/Media/Video",
    '.mpeg': "/home/mauricio/Media/Video",
    '.rm': "/home/mauricio/Media/Video",
    '.swf': "/home/mauricio/Media/Video",
    '.vob': "/home/mauricio/Media/Video",
    '.wmv': "/home/mauricio/Media/Video",
#Images
    '.ai': "/home/mauricio/Media/Images",
    '.bmp': "/home/mauricio/Media/Images",
    '.gif': "/home/mauricio/Media/Images",
    '.ico': "/home/mauricio/Media/Images",
    '.jpg': "/home/mauricio/Media/Images",
    '.jpeg': "/home/mauricio/Media/Images",
    '.png': "/home/mauricio/Media/Images",
    '.ps': "/home/mauricio/Media/Images",
    '.psd': "/home/mauricio/Media/Images",
    '.svg': "/home/mauricio/Media/Images",
    '.tif': "/home/mauricio/Media/Images",
    '.tiff': "/home/mauricio/Media/Images",
    '.CR2': "/home/mauricio/Media/Images",
#Internet
    '.asp': "/home/mauricio/Other/Internet",
    '.aspx': "/home/mauricio/Other/Internet",
    '.cer': "/home/mauricio/Other/Internet",
    '.cfm': "/home/mauricio/Other/Internet",
    '.cgi': "/home/mauricio/Other/Internet",
    '.pl': "/home/mauricio/Other/Internet",
    '.css': "/home/mauricio/Other/Internet",
    '.htm': "/home/mauricio/Other/Internet",
    '.js': "/home/mauricio/Other/Internet",
    '.jsp': "/home/mauricio/Other/Internet",
    '.part': "/home/mauricio/Other/Internet",
    '.php': "/home/mauricio/Other/Internet",
    '.rss': "/home/mauricio/Other/Internet",
    '.xhtml': "/home/mauricio/Other/Internet",
#Compressed
    '.7z': "/home/mauricio/Other/Compressed",
    '.arj': "/home/mauricio/Other/Compressed",
    '.deb': "/home/mauricio/Other/Compressed",
    '.pkg': "/home/mauricio/Other/Compressed",
    '.rar': "/home/mauricio/Other/Compressed",
    '.rpm': "/home/mauricio/Other/Compressed",
    '.tar.gz': "/home/mauricio/Other/Compressed",
    '.z': "/home/mauricio/Other/Compressed",
    '.zip': "/home/mauricio/Other/Compressed",
#Disc
    '.bin': "/home/mauricio/Other/Disc",
    '.dmg': "/home/mauricio/Other/Disc",
    '.iso': "/home/mauricio/Other/Disc",
    '.toast': "/home/mauricio/Other/Disc",
    '.vcd': "/home/mauricio/Other/Disc",
#Data
    '.csv': "/home/mauricio/Programming/Database",
    '.dat': "/home/mauricio/Programming/Database",
    '.db': "/home/mauricio/Programming/Database",
    '.dbf': "/home/mauricio/Programming/Database",
    '.log': "/home/mauricio/Programming/Database",
    '.mdb': "/home/mauricio/Programming/Database",
    '.sav': "/home/mauricio/Programming/Database",
    '.sql': "/home/mauricio/Programming/Database",
    '.tar': "/home/mauricio/Programming/Database",
    '.xml': "/home/mauricio/Programming/Database",
    '.json': "/home/mauricio/Programming/Database",
#Executables
    '.apk': "/home/mauricio/Other/Executables",
    '.bat': "/home/mauricio/Other/Executables",
    '.com': "/home/mauricio/Other/Executables",
    '.exe': "/home/mauricio/Other/Executables",
    '.gadget': "/home/mauricio/Other/Executables",
    '.jar': "/home/mauricio/Other/Executables",
    '.wsf': "/home/mauricio/Other/Executables",
#Fonts
    '.fnt': "/home/mauricio/Other/Fonts",
    '.fon': "/home/mauricio/Other/Fonts",
    '.otf': "/home/mauricio/Other/Fonts",
    '.ttf': "/home/mauricio/Other/Fonts",
#Presentations
    '.key': "/home/mauricio/Text/Presentations",
    '.odp': "/home/mauricio/Text/Presentations",
    '.pps': "/home/mauricio/Text/Presentations",
    '.ppt': "/home/mauricio/Text/Presentations",
    '.pptx': "/home/mauricio/Text/Presentations",
#Programming
    '.c': "/home/mauricio/Programming/C",
    '.class': "/home/mauricio/Programming/Java",
    '.dart': "/home/mauricio/Programming/Dart",
    '.py': "/home/mauricio/Programming/Python",
    '.sh': "/home/mauricio/Programming/Shell",
    '.swift': "/home/mauricio/Programming/Swift",
    '.html': "/home/mauricio/Programming/C",
    '.h': "/home/mauricio/Programming/C",
#Spreadsheets
    '.ods' : "/home/mauricio/Text/Microsoft/Excel",
    '.xlr' : "/home/mauricio/Text/Microsoft/Excel",
    '.xls' : "/home/mauricio/Text/Microsoft/Excel",
    '.xlsx' : "/home/mauricio/Text/Microsoft/Excel",
#System
    '.bak' : "/home/mauricio/Text/Other/System",
    '.cab' : "/home/mauricio/Text/Other/System",
    '.cfg' : "/home/mauricio/Text/Other/System",
    '.cpl' : "/home/mauricio/Text/Other/System",
    '.cur' : "/home/mauricio/Text/Other/System",
    '.dll' : "/home/mauricio/Text/Other/System",
    '.dmp' : "/home/mauricio/Text/Other/System",
    '.drv' : "/home/mauricio/Text/Other/System",
    '.icns' : "/home/mauricio/Text/Other/System",
    '.ico' : "/home/mauricio/Text/Other/System",
    '.ini' : "/home/mauricio/Text/Other/System",
    '.lnk' : "/home/mauricio/Text/Other/System",
    '.msi' : "/home/mauricio/Text/Other/System",
    '.sys' : "/home/mauricio/Text/Other/System",
    '.tmp' : "/home/mauricio/Text/Other/System",
}

folder_to_track = '/home/mauricio/Downloads'
folder_destination = '/home/mauricio/'
event_handler = MyHandler()
observer = Observer()
observer.schedule(event_handler, folder_to_track, recursive=True)
observer.start()

try:
    while True:           
        time.sleep(10)
except KeyboardInterrupt:
    observer.stop()
observer.join()
