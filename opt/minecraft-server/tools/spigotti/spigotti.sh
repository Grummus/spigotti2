#!/bin/bash

# server vars
serverdir="<serverpath>"
backtitle="Spigotti 2.0"
CONFIG="$serverdir/config"

# import vars from server's config file
source "$CONFIG"
source "tools/spigotti/start"

# make tempfiles for dialog interactions
INPUT=/tmp/menu.sh.$$
OUTPUT=/tmp/output.sh.$$

# delete tempfiles on exit or sigterm
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

cd $serverdir

# uncomment for borders fix with PuTTY
export NCURSES_NO_UTF8_ACS=1

dialog --backtitle "$backtitle" --title "Home" \
--menu "Welcome!" 15 50 4 \
1 "Start/Reconnect" \
2 "Update Server" \
3 "Exit" 2>"${INPUT}"

response=$(<"${INPUT}")
case $response in
	1) launch;; 
	2) update && check;;
esac

quit