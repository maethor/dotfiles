# -*- coding: utf-8 -*-

# import subprocess

import os

from i3pystatus import Status
import netifaces

green = "#8ae234"
yellow = "#fce94f"
orange = "#f57900"
red = "#ef2929"
gray = "#aaaaaa"
white = "#ffffff"

status = Status(standalone=True)

status.register(
    "keyboard_locks", format="{caps}", caps_off="", caps_on=" CAPS", color=red
)

status.register("clock", format="   %a %d/%m %X ")

if os.uname()[1] == "stark":
    status.register(
        "battery",
        format=" {status}  {percentage:.1f}% {remaining:%E%h:%M} ",
        alert=True,
        alert_percentage=5,
        status={"DIS": "", "CHR": "", "FULL": ""},
        not_present_text="  ",
        full_color=white,
        charging_color=yellow,
        critical_color=red,
        not_present_color=gray,
    )

# status.register("disk", path="/", format="{used}/{total}G [{avail}G]",)

# status.register("alsa", format="   {volume}% ",
#                increment=2)

status.register("backlight", backlight="intel_backlight", format="   {percentage}% ")

# status.register("pulseaudio", format="   {volume}% ")

# status.register("cpu_usage", format="   {usage:02}% ")

status.register(
    "mem",
    format="   {percent_used_mem:.0f} %",
    color=white,
    warn_percentage=90,
    alert_percentage=95,
)

# if os.uname()[1] == 'stark':
#    status.register("temp", format=" {temp:.0f}°C ")

# status.register("network_traffic", interface="wlan0")

# base_net_format_up = " {v4cidr} "
# interfaces = netifaces.interfaces()
#
# for interface in interfaces:
#    if ':' not in interface:
#        if interface.startswith('wlan'):
#            # Wireless network
#            status.register("wireless", interface=interface,
#                            format_up="   {essid} ({quality:.2f}%) ",
#                            format_down = " {interface} ",
#                            color_up=green,color_down=red,)
#        elif interface.startswith('eth'):
#            # Wired network
#            status.register("network", interface=interface,
#                            format_up=base_net_format_up,
#                            format_down = " {interface} ",
#                            color_up=green,color_down=red,)
#            #status.register("network_traffic", interface=interface)
#        elif interface.startswith('tun'):
#            # Wired network
#            status.register("network", interface=interface, format_up="  "+base_net_format_up,
#                            color_up=green,color_down=red, unknown_up=True)

# FDN VPN
# status.register("network", interface=interface,
#                format_up="FDN: {v6cidr} {v4cidr}",
#                format_down="FDN: down",
#                unknown_up=True,)
#
# status.register("network",
#    interface="eth0",
#    format_up="{v4cidr}",)
#
# status.register("wireless",
#    interface="wlan0",
#    format_up="{essid} {quality:03.0f}%",)


# status.register("shell", command="~/.bin/boobank_i3.sh", interval=60)

# Shows mpd status
# Format:
# Cloud connected▶Reroute to Remain
status.register(
    "mpd",
    format=" {status}  {artist} - {album} - {title} ",
    status={"pause": "  ", "play": "  ", "stop": "  "},
)

# status.register("shell", command="/home/maethor/.i3/focustitle.sh",
#                format=" {output} ")

status.run()
