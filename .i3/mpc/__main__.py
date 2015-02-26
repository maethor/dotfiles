#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 nu

from __future__ import (unicode_literals, absolute_import,
                        division, print_function)

import os
import sys
import notify2


default_cover = os.environ['HOME'] + "/.i3/mpc/default_cover.jpg"
COVER_SIZE = 75
music_folder = os.environ['HOME'] + "/Musique"


def next_track():
    os.popen("mpc next")
    notify()

def prev_track():
    os.popen("mpc prev")
    notify()

def play_pause():
    os.popen("mpc toggle")
    notify()

def get_cover():
    filename = os.popen("mpc -f '%file%'").readlines()[0][:-1]
    folder = music_folder + '/' + os.path.dirname(filename)
    covers = filter(lambda x: x.endswith('.jpg') or x.endswith('.png') or x.endswith('.gif'), os.listdir(folder))
    if covers:
        return (folder + '/' + next(covers))
    else:
        return default_cover

def notify():
    i = dict()
    i['track'] = os.popen("mpc -f '%track%'").readlines()[0][:-1]
    i['title'] = os.popen("mpc -f '%title%'").readlines()[0][:-1]
    i['album'] = os.popen("mpc -f '%album%'").readlines()[0][:-1]
    i['artist'] = os.popen("mpc -f '%artist%'").readlines()[0][:-1]

    misc = os.popen("mpc").readlines()[1][:-1]
    if "playing" in misc:
        i['status'] = misc.replace("playing", "<span color='#73d216'>playing</span>")
    elif "paused" in misc:
        i['status'] = misc.replace("paused", "<span color='#f57900'>paused</span>")
    else:
        i['status'] = misc

    # This is ugly
    if misc[-2] == '%':
        if misc[-4] != '(':
            i['progress'] = int(misc[-4:-2])
        else:
            i['progress'] = int(misc[-3])

    msg = "%(track)s - %(title)s\n%(artist)s - %(album)s\n%(status)s" % i

    notify2.init('MPC')
    n = notify2.Notification("Now playing:", msg, get_cover())
    n.set_hint('progress', 80) # Doesn't work with dunst :(
    n.show()
    
    pass

if __name__ == '__main__':
    if len(sys.argv) < 1:
        print("Error not enough arguements")
    else:
        command = sys.argv[1]
        if command == 'play_pause':
            play_pause()
        elif command == 'next':
            next_track()
        elif command == 'prev':
            prev_track()
        elif command == 'notify':
            notify()
