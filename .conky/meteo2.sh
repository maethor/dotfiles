#!/bin/bash

# Fichier où sont stockées les informations
SRCFILE=/tmp/conky_meteo.txt

# Traitement
RESULTAT=$(grep "$1" $SRCFILE | awk -F " : " '{print $2}')

# Transformation de la condition en lettre qui deviendra une icône
if echo "$1" | grep -i -q 'condition'; then
	  if echo "$RESULTAT" | grep -i -q 'partly cloudy'; then
		RESULTAT='c'
	elif echo "$RESULTAT" | grep -i -q 'fair'; then
		RESULTAT='b'
	elif echo "$RESULTAT" | grep -i -q 'sunny'; then
		RESULTAT='D'
	elif echo "$RESULTAT" | grep -i -q 'cloudy'; then
		RESULTAT='d'
	elif echo "$RESULTAT" | grep -E -i -q 'storm|thunder'; then
		RESULTAT='i'
	elif echo "$RESULTAT" | grep -i -q 'snow'; then
		RESULTAT='k'
	elif echo "$RESULTAT" | grep -i -q 'rain'; then
		RESULTAT='h'
	elif echo "$RESULTAT" | grep -i -q 'shower'; then
		RESULTAT='g'
	fi

# Transformation des heures à l'américaine (5:50 AM) en heures à la française (5h50)
elif echo "$1" | grep -i -q 'soleil'; then
	RESULTAT=$(echo "$RESULTAT" | awk '{print $1}' | sed -e s/:/h/g)

	# Transformation des heures PM (9h38 PM) en heures françaises (21h38)
	if echo "$1" | grep -i -q 'coucher'; then
		HEURES=$(echo "$RESULTAT" | awk -F "h" '{print $1}')
		MINUTES=$(echo "$RESULTAT" | awk -F "h" '{print $2}')
		HEURES=$(($HEURES + 12))
		RESULTAT="${HEURES}h${MINUTES}"
	fi

# Transformation de "Ville, Pays" en "Ville"
elif echo "$1" | grep -i -q 'ville'; then
	RESULTAT=$(echo "$RESULTAT" | awk -F "," '{print $1}')

fi

# Affichage du résultat
echo $RESULTAT
