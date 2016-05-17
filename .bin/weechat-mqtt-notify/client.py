#!/usr/bin/env python3

import paho.mqtt.client as mqtt
import json
import re
import os


from config import *


def escape(s):
    return re.sub(r'([\\"])', r'\\\1', s)


def on_message(mosq, obj, msg):
    m = json.loads(msg.payload.decode("utf-8"))

    try:
        if m['data'] == "private" or m["highlight"] == "1" or re.match("#sysnove|#sysnove-staff|#pulseo|#general", m['buffer']) and not (m['sender'] == "Jarvis" and re.match(".*(Unbanned|Banned) address.*", m['message'])):
            if m['data'] == 'private':
                m['buffer'] = 'me'
            os.system('notify-send -a "weechat" -c "IRC" "%s to %s" "%s"' % (escape(m['sender']), escape(m['buffer']), escape(m['message'])))

    except Exception as e:
        print(m)
        print(e)
 

cli = mqtt.Client()
cli.on_message = on_message
cli.username_pw_set(USER, password=PASSWORD)
cli.connect(HOST, PORT)
cli.subscribe(CHANNEL, 0)
 
cli.loop_forever()
