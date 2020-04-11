#!/bin/bash

function serverman () {
    title="Server Manager"
    i=0
    servernames=
    serverstatus=
    for server in $workingdir/servers/*; do
        if [ -d "$server" ] ; then
            source "$server/config"
            servernames[$i]=$servername
            service minecraft@$servername status
            if [ $? == 0 ] ; then
                serverstatus[$i]="Active"
            else
                serverstatus[$i]="Inactive"
            fi
            loopint=$(expr $loopint + 1)
            echo "$server loaded"
        fi
    done

    read -p "Pausing serverman..." pause
    exit

    dialog --backtitle "$backtitle" --title $title \
    --menu ""
}