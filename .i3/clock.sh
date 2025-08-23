#!/bin/sh

date +'   %a %d/%m %H:%M:%S'

if [ "$(($(date +%s) - $(date -r ~/.i3/clock.status +%s)))" -gt 1800 ]; then
    exit 1
else
    exit 0
fi

#exit "$(cat ~/.i3/clock.status)"
