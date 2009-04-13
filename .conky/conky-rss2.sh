#!/bin/bash
# Ce script a besoin de Curl pour fonctionner.  
# http://curl.haxx.se/
#
# Utilisation dans le conkyrc
# .conkyrc:    ${execi [time] /path/to/script/conky-rss.sh URI LINES TITLENUM}
#    URI = Flux RSS concerné, ex. http://www.gentoo.org/rdf/en/glsa-index.rdf
#    LINES = Combien de titres afficher ? 5 par défaut
#    TITLENUM = Combien de fois le titre est il affiché ? Souvent 1 ou 2 (2 par défaut)
#
# Exemple d'utilisation        
#        ${execi 300 /home/youruser/scripts/conky-rss.sh http://www.foxnews.com/xmlfeed/rss/0,4313,1,00.rss 4 2}

#Réglages du RSS. Changez ces valeurs dans la commande !
uri=$1                            #URI du flux RSS
lines=$2                        #Nombre de titres
titlenum=$3                        #Nombre d'affichage des titres

#Début du script
#Le script nécessite une URI au minimum
if [[ "$uri" == "" ]]; then
    echo "Par d'URI spécifié !" >&2
    echo "Merci de lire le script pour plus d'informations." >&2
else
    #Si les réglages ne sont pas spécifiés -> Réglages par défaut
    if [[ $lines == "" ]]; then lines=5 ; fi
    if [[ $titlenum == "" ]]; then titlenum=2 ; fi

    #La fonction
    curl -s --connect-timeout 30 $uri |\
    sed -e 's/<\/title>/\n/g' |\
    grep '<title>.*' |\
    sed -e 's/<title>//' |\
    head -n $(($lines + $titlenum)) |\
    tail -n $(($lines))
fi
