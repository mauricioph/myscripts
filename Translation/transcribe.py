#!/usr/bin/python3
# Dependencies pip install pydub SpeechRecognition

import speech_recognition as sr
from os import path
from pydub import AudioSegment

# convert mp3 file to wav
sound = AudioSegment.from_mp3("/tmp/transcript.mp3")
sound.export("/tmp/transcript.wav", format="wav")


# transcribe audio file
AUDIO_FILE = "/tmp/transcript.wav"

# use the audio file as the audio source
r = sr.Recognizer()
with sr.AudioFile(AUDIO_FILE) as source:
        audio = r.record(source)  # read the entire audio file
        mensagem="Start: " + r.recognize_google(audio, language='pt-BR')

# write file appending each line to it.	
with open('/tmp/BishopMacedo.txt', 'a') as f:
	f.write(mensagem)
	f.write('\n')
