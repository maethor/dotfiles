#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 nu


#from __future__ import (unicode_literals, absolute_import,
#                        division, print_function)

import notify2
import acpi
import redis


BATTERY_NAME = "BAT0"
NOTIFICATION_APP = "battery-notify"
NOTIFICATION_TITLE = "Battery"

WARN_LVL = 15
CRIT_LVL = 5
REALLY_CRIT_LVL = 0

WARN_MSG = "Battery level is under 15%!"
CRIT_MSG = "Warning: Battery level is now under 5%!"
REALLY_CRIT_MSG = "CRITICAL: Are you crazy? Plug on the AC right now!"

def notify(msg, urgency=notify2.URGENCY_NORMAL):
    msg = msg
    notify2.init(NOTIFICATION_APP)
    n = notify2.Notification(NOTIFICATION_TITLE, msg)
    n.set_urgency(urgency)
    n.show()

if __name__ == "__main__":
    r = redis.StrictRedis()

    bats = acpi.acpi()
    if bats:
        new = bats[0]
    else:
        new = None

    old = eval(r.get('Battery'))
    r.set('Battery', new)

    if old or new:
        if old and not new:
            notify("No battery found.")

        elif new and not old:
            notify("New battery found.")

        elif new[2] <= REALLY_CRIT_LVL < old[2]:
            notify(REALLY_CRIT_MSG, notify2.URGENCY_CRITICAL)

        elif new[2] <= CRIT_LVL < old[2]:
            notify(CRIT_MSG, notify2.URGENCY_CRITICAL)

        elif new[2] <= WARN_LVL < old[2]:
            notify(WARN_MSG)

        elif new[1] != old[1]:
            notify(new[1])
