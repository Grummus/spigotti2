function mkserver () {
    clear
    echo "Ah, a new beginning!"
    read -p "Name your new server: " servername
    read -p "How much RAM shall I allocate to it? (eg. 2G) " serverram
    read -p "Which port would you like your server to be hosted on? [Default: 25565] " serverport
    mkdir $workingdir/servers/$servername
    cd $workingdir/servers/$servername
    echo "servername=$servername" >> config
    echo "MINRAM=$serverram" >> config
    echo "MAXRAM=$serverram" >> config

    if [ $serverport = null ]; then
        serverport=25565
    fi

    echo "server-port=$serverport" >> server.properties
    echo "query.port=$serverport" >> server.properties
    rconport=$(expr $serverport + 10)
    echo "rcon.port=$rconport" >> server.properties

    # make server start script
    echo "sudo systemctl start minecraft@servername.service" >> start.sh
    chmod +x start.sh

    update $servername
}