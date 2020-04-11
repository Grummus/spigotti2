#!/bin/bash

# vars
# CHANGE THIS TO /opt/minecraft-server
workingdir="/home/graham/coding/spigotti2/package/opt/minecraft-server"
tooldir="opt/minecraft-server/tools/spigotti"
backtitle="Spigotti 2.0"


# make tempfiles for dialog interactions
INPUT=/tmp/menu.sh.$$
OUTPUT=/tmp/output.sh.$$

# delete tempfiles on exit or sigterm
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

cd $workingdir

# uncomment for borders fix with PuTTY
export NCURSES_NO_UTF8_ACS=1

# source all files in spigotti dir
for file in $workingdir/tools/spigotti/*; do
  if [ -f "$file" ] ; then
    source "$file"
	echo "$file loaded!"
  fi
done
read -p "Pausing..." ree

function quit {
	clear
	exit
}

# MAIN PROGRAM LOOP
# while true; do
	cd $serverdir
	dialog --backtitle "$backtitle" --title "Home" \
	--menu "Welcome!" 15 50 8 \
	1 "Server Manager" \
	2 "Server Stats" \
	3 "Create a new server" \
	4 "Delete a Server" \
	5 "System Info" \
	6 "File manager" \
	7 "Exit" 2>"${INPUT}"

	response=$(<"${INPUT}")
	case $response in
		1) serverman;; 
		2) serverstat;;
		3) mkserver;;  
		4) delserver;; 
		5) gtop;; 
		6) ranger;;
		7) quit;;
	esac
# done
read -p "Pausing..." yeetus
quit
# exit