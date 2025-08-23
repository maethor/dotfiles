#!/bin/sh

xrandr --output VGA-1 --off --output DP-1 --off --output LVDS-1 --auto

i3-nagbar -m "EBRND'S SUPER-COOL I3WM SCREEN CONFIG UTILITY" -t warning \
    -b "LVDS + DP"  "xrandr --output VGA-1 --off --output LVDS-1 --auto --output DP-1 --auto --right-of LVDS-1" \
    -b "LVDS + VGA"  "xrandr --output DP-1 --off --output LVDS-1 --auto --output VGA-1 --auto --right-of LVDS-1" \
    -b "VGA ONLY"    "xrandr --output LVDS-1 --off --output DP-1 --off --output VGA-1 --auto"

#sh ~/.fehbg
