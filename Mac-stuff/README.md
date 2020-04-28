These files are all to work together, I use it on my work and there are some goals here, which are the following:
* Everyday before a meeting iTunes will turn on and select the playlist of the day and will play it 30 minutes before each meeting.
* When there is 1 minute left to start the meeting, the songs will stop and an instrumental song will start to intruduce the time of the meeting.
* When the meeting starts iTunes should stop playing.

## How they work?

**crontab** is the scheduling of the meetings and which scripts it should call.
**tocarmusica.py** is a python script which will call the script of the day
**Week days named scripts** They will load iTunes, lower the volume all the way, start playing the playlist and slowly raise the volume of the audio
**fundo** will stop the playlist and start playing the instrumental song. (Not included here because of copright "obviously".)
**mapkeys** Ok, this is exclusive for my macbook pro... which had the ctrl key broken and basically this script remap my keys, so capslock work as ctrl and right shift is capslock.
**wake** this is the original idea, wake up iTunes and play the playlist... the others are improvements upon this script.
