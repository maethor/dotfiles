#!/bin/bash

if [ -e $HOME/.muttrc.d/specifics/$HOSTNAME ] ; then
    cat $HOME/.muttrc.d/specifics/$HOSTNAME
else
    cat $HOME/.muttrc.d/specifics/default
fi
