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
        print ("Transcription: " + r.recognize_google(audio))

sublime="Transcription: " + r.recognize_google(audio)
with open('/tmp/treino.txt', 'a') as f:
	f.write(sublime)
	f.write('\n')

