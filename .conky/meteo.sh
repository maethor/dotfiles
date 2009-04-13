#!/bin/bash

# Répertoire de ce script et du XSLT
RUNDIR=~/.conky
# Emplacement du XSLT
XSLT=$RUNDIR/meteo.xslt
# Fichier de destination des informations
DESTFILE=/tmp/conky_meteo.txt
# Emplacement de xsltproc
XSLTCMD=/usr/bin/xsltproc

# Traitement
URL="http://xoap.weather.com/weather/local/$1?cc=*&unit=m&dayf=2"
w3m -dump $URL | $XSLTCMD $XSLT - > $DESTFILE
