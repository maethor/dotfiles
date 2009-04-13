#!/bin/bash

# voir ip derriere routeur

wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1 | tail
