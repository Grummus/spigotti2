#!/bin/bash

# check if user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo or as root" 
   exit 1
fi


export NCURSES_NO_UTF8_ACS=1 

backtitle="Graham's Crappy Server Launcher"
title="Installer"

INPUT=/tmp/menu.sh.$$

OUTPUT=/tmp/output.sh.$$

trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

DEPS="vim screen ranger nodejs npm dialog"

echo "SpigotTI requires the following dependencies: $DEPS"
read -p "Install Dependencies? [y/n] " depyesno

[ ! $depyesno == y ] && exit 1
apt update $$ apt install $DEPS

cd package
# cp -R * /

