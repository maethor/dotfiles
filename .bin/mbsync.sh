#!/bin/bash

# create a FIFO file, used to manage the I/O redirection from shell
PIPE=$(mktemp -u --tmpdir ${0##*/}.XXXXXXXX)
mkfifo $PIPE

# attach a file descriptor to the file
exec 3<> $PIPE

# add handler to manage process shutdown
function on_exit() {
    echo "quit" >&3
    rm -f $PIPE
}
trap on_exit EXIT

# add handler for tray icon left click
function on_click() {
    exec 3<> $1
    sync subiron:sysnove
}
export -f on_click

function sync() {
    echo "icon:emblem-synchronizing-symbolic" >&3
    echo "tooltip:Synchronisation '$1' en cours" >&3

    mbsync $1

    if [ $? -eq 0 ]; then
        if [ $(ls ~/Maildir/sysnove/new/ | wc -l) -gt 1 ] ; then
            #echo "icon:mail-message-new-symbolic" >&3
            echo "icon:mail-mark-important-symbolic" >&3
        else
            #echo "icon:emblem-ok-symbolic" >&3
            echo "icon:mail-read" >&3
        fi
        echo "tooltip:Synchronisé le $(date)" >&3
    else
        #echo "icon:emblem-important-symbolic" >&3
        #echo "icon:mail-mark-important-symbolic" >&3
        echo "icon:software-update-urgent" >&3
        echo "tooltip:Échec de synchronisation le $(date)" >&3
    fi
}

export -f sync

# create the notification icon
yad --notification                  \
    --listen                        \
    --image="mail-unread"              \
    --text="Emails non synchronisés"   \
    --command="bash -c 'on_click $PIPE'" <&3 &

while true; do
    sync -a
    sleep 20
    sync subiron:sysnove
    sleep 20
    sync subiron:sysnove
    sleep 20
done
