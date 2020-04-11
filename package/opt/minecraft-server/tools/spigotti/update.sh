title="Server Updater"
function update () {
    serverdir=$workingdir/servers/$1
    if ! tmux ls | grep $server; then
        cd $serverdir
        dialog --backtitle "$backtitle" --title "$title" \
        --menu "Select A Server Type:" 15 50 4 \
        spigot "(Recommended)" \
        craftbukkit "" \
        quit "Ack! Get me out of here!" 2>"${INPUT}"
        if [ "$?" = "0" ]; then
            servertype=$(<"${INPUT}")
            if [ "$servertype" = "quit" ];then
                quit
            fi
        else
            exit 1
        fi

        dialog --backtitle "$backtitle" --title "$title" \
        --inputbox "Enter Server Version" 8 30 2>"${INPUT}"
        mcver=$(<"${INPUT}")
        [ ! "$?" = 0 ] && exit 1
        clear
        if [ ! -d "buildtools" ]; then
            echo "Creating 'buildtools' directory..."
            mkdir buildtools
        fi
        echo "BUILDING $servertype VERSION $mcver"
        cd buildtools
        echo Downloading latest BuildTools...
        wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
        echo Beginning Build Process...
        java -jar BuildTools.jar --rev $mcver
        echo Copying server JAR...
        cp "$servertype-$mcver.jar" "../"
        cd ..
        echo
        echo "Done!"
        echo "Writing Config File..."
        echo "servertype=$servertype" >> config
        echo "mcver=$mcver" >> config
        read -p "Press [Enter] to Continue..."
        if [ -f "$serverdir/$servertype-$mcver.jar" ]; then
            dialog --backtitle "$backtitle" --title "Success!" \
            --msgbox "Everything built successfully!" 8 40
            quit
        else
            dialog --backtitle "$backtitle" --title "!!!ERROR!!!" \
            --msgbox "A build error occured!\nInstallation Incomplete" 8 40
            exit 1
        fi
    else
        dialog --backtitle "$backtitle" --title "WARNING!" --msgbox "Please shut your server off\nbefore updating!" 8 50
        exit 255
    fi
}