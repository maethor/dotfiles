#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 nu


from __future__ import (unicode_literals, absolute_import,
                        division, print_function)

import os


#outputs = [ "LDVS1", "VGA1", "DP1", "HDMI1" ]
position = "above"


def reset():
    default = "eDP-1"
    cmd = "xrandr"
    outs = screens()
    if default not in outs:
        default = outs[0]
    for out in outs:
        if out != default:
            cmd += " --output " + out + " --off"
    cmd += " --output " + default + " --auto"
    print(cmd)
    return os.popen(cmd) 


def screens():
    return (line.split(' ')[0]
            for line in os.popen("xrandr -q").readlines()
            if " connected " in line)


def choices(screens):
    choices = list()
    for i in screens:
        choices.append([i])
        for j in screens:
            if i != j:
                choices.append([i, j])
    return choices


def menu():
    s = screens()

    m = "i3-nagbar -m \"MENU\" -t warning"

    for choice in choices(s):
        cmd = "xrandr --auto"
        for i, screen in enumerate(choice):
            cmd += " --output " + screen + " --auto"
            if i > 0:
                cmd += " --" + position + " " + choice[i-1]
        m += ' -b "' + ' + '.join(choice) + '" "' + cmd + '"'

    print(m)
    return os.popen(m)


if __name__ == "__main__":
    reset()
    menu()
