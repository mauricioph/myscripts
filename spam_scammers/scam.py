import requests
import os
import random
import string
import json
import time

chars = string.ascii_letters + string.digits + '!@#$%^&*()'
random.seed = (os.urandom(1024))

url = 'http://craigslist.pottsfam.com/index872dijasydu2iuad27aysdu2yytaus6d2ajsdhasdasd2.php'

providers = [ "gmail.com", "yahoo.com", "mail.com", "outlook.com", "gmx.com", "protomail.com", "aol.com", "hotmail.com", "live.com", "icloud.com", "me.com"]
names = json.loads(open('names.json').read())

for name in names:

	name_extra = ''.join(random.choice(string.digits) for i in range(4))
	username = name.lower() + name_extra + '@' + random.choice(providers)
	password = ''.join(random.choice(chars) for i in range(8))
        
	# add time to avoid the server to ban your ip because of abuse of posts
	time.sleep(10)
	requests.post(url, allow_redirects=False, data={
		'auid2yjauysd2uasdasdasd': username,
		'kjauysd6sAJSDhyui2yasd': password
	})

	print 'sending username %s and password %s' % (username, password)
