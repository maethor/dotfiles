# -*- coding: utf-8 -*-

#import subprocess

import os

from i3pystatus import Status
import netifaces

green = "#8ae234"
yellow = "#fce94f"
orange = "#f57900"
red = "#ef2929"
fg = "#aaaaaa"
gray = "#aaaaaa"

status = Status(standalone=True)

status.register("clock", format="🕗 %a %d/%M %X",)

if os.uname()[1] == 'stark':
    status.register("battery",
                    format="🔋 {percentage:.1f}% {remaining:%E%h:%M}",
                    alert=True, alert_percentage=5,
                    status={ "DIS": "↓", "CHR": "↑", "FULL": "=", },
                    not_present_text = "N/A",
                    color=fg,
                    full_color=green,
                    charging_color=yellow,
                    critical_color=red,
                    not_present_color=gray,
                    )

#status.register("disk", path="/", format="{used}/{total}G [{avail}G]",)

status.register("alsa", format="🔈 {volume}%", increment=2)

status.register("cpu_usage", format="CPU {usage:02}%")

status.register("mem",
                format="MEM {used_mem:.0f}MiB/{total_mem:.0f}MiB",
                color="#ffffff",
                warn_percentage=70, alert_percentage=90)

if os.uname()[1] == 'stark':
    status.register("temp", format="{temp:.0f}°C")

#status.register("network_traffic", interface="wlan0")

base_net_format_up = "{v4cidr}"
interfaces = netifaces.interfaces()

for interface in interfaces:
    if interface.startswith('wlan'):
        # Wireless network
        status.register("wireless", interface=interface,
                        format_up="{essid} ({quality:.2f}%): " + base_net_format_up,
                        color_up=green,color_down=red,)
    elif interface.startswith('eth'):
        # Wired network
        status.register("network", interface=interface, format_up=base_net_format_up,
                        color_up=green,color_down=red,)
    elif interface.startswith('tun'):
        # Wired network
        status.register("network", interface=interface, format_up="VPN "+base_net_format_up,
                        color_up=green,color_down=red, unknown_up=True)

# FDN VPN
#status.register("network", interface=interface,
#                format_up="FDN: {v6cidr} {v4cidr}",
#                format_down="FDN: down",
#                unknown_up=True,)
#
#status.register("network",
#    interface="eth0",
#    format_up="{v4cidr}",)
#
#status.register("wireless",
#    interface="wlan0",
#    format_up="{essid} {quality:03.0f}%",)

# Shows mpd status
# Format:
# Cloud connected▶Reroute to Remain
status.register("mpd",
    format="{status} {album} - {title}",
    status={
        "pause": " ▷ ",
        "play": " ▶ ",
        "stop": " ◾ ",
    },)

status.run()
