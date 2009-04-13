#!/bin/bash

#CE SCRIPT DEMANDE UNE CHAINE DE CARACTERES ET L'AJOUTE DANS LE FICHIER "NOTES" AFFICHÉ DANS LE CONKY

FICHIERNOTES=~/.conky/notes.txt

case $# in

	0)
	echo "Que voulez vous faire ?
		1 - Entrer une nouvelle note
		2 - Voir les notes
		3 - Editer le fichier des notes
		4 - Vider les notes
	"
	
	read CHOIX
	
	case $CHOIX in
		1)
		echo "Entrez la note : " ; read TEXTE
		echo "$TEXTE" >> $FICHIERNOTES
		echo "La note a bien été ajoutée"
		;;
		2)
		cat $FICHIERNOTES
		;;
		3)
		vim $FICHIERNOTES
		;;
		4)
		echo "Etes vous sur de vouloir supprimer les notes ? (Y/N)"
		read CHOIX2
		if ["$CHOIX2" -eq "Y" -o 
		    "$CHOIX2" -eq "YES" -o 
		    "$CHOIX2" -eq "yes" -o 
		    "$CHOIX2" -eq "y"] ; 
    			then echo "" > $FICHIERNOTES
			echo "Les notes ont été supprimées"
		fi
		;;
		*)
		echo "Choix indisponible"
	esac
	;;

	1)
	echo "$1" >> $FICHIERNOTES
	echo "La note a bien été ajoutée"
	;;

	2)
	echo "$1" >> $FICHIERNOTES
	echo "$2" >> $FICHIERNOTES
	echo "Les notes ont bien été ajoutées"
	;;

	3)
	echo "$1" >> $FICHIERNOTES
	echo "$2" >> $FICHIERNOTES
	echo "$3" >> $FICHIERNOTES
	echo "Les notes ont bien été ajoutées"
	;;
	
	4)
	echo "$1" >> $FICHIERNOTES
	echo "$2" >> $FICHIERNOTES
	echo "$3" >> $FICHIERNOTES
	echo "$4" >> $FICHIERNOTES
	echo "Les notes ont bien été ajoutées"
	;;
	
	5)
	echo "$1" >> $FICHIERNOTES
	echo "$2" >> $FICHIERNOTES
	echo "$3" >> $FICHIERNOTES
	echo "$4" >> $FICHIERNOTES
	echo "$5" >> $FICHIERNOTES
	echo "Les notes ont bien été ajoutées"
	;;
	
	*)
	echo "Trop d'arguments, pas plus de 5 acceptés"		
esac

exit 0
