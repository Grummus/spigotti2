#!/bin/bash

function serverman () {
    title="Server Manager"
    loopint="1"
    for server in $workingdir/servers/*; do
        if [ -d "$server" ] ; then
            source "$server/config"
            loopint=$($loopint + 1)
            echo "$server loaded"
        fi
    done

    read -p "Pausing..." pause
    exit

    dialog --backtitle "$backtitle" --title $title \
    --menu ""
}