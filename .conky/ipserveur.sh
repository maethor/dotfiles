#!/bin/zsh

# CE SCRIPT SERT A VERIFIER SI UN SERVEUR EST VISIBLE. SI C EST LE CAS IL RETOURNE SON IP, SINON IL RETOURNE "SERVEUR INVISIBLE"

HOSTNAME=subiron.org

ping -c 1 $HOSTNAME > /dev/null 2>&1 

if [ $? -eq 0 ] ;
then
	IP=$(nslookup $HOSTNAME | grep -n Address | grep 6: | cut -d \  -f 2)
	echo "$IP";
else
	echo "Serveur invisible";
fi


