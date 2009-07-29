#!/bin/zsh
setopt extendedglob

if [ -d $HOME/.zshrc.d ]
then for zshrc_file in `/bin/run-parts --test $HOME/.zshrc.d`
    do source $zshrc_file
    done
unset zshrc_file
fi

