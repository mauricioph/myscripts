#!/usr/bin/python

import os
import subprocess
import datetime

x = datetime.datetime.now()

print(x.strftime("%A"))
subprocess.call(x.strftime("%A"), shell=True)
