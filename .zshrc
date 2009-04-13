#!/bin/zsh

# /etc/zsh/zshrc ou ~/.zshrc
# Fichier de configuration principal de zsh
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/

setopt extendedglob

if [ -d $HOME/.zshrc.d ]
then for zshrc_file in `/bin/run-parts --list $HOME/.zshrc.d`
    do source $zshrc_file
    done
unset zshrc_file
fi


