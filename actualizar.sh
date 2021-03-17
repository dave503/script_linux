#!/bin/bash

echo 'Actualizando paquetes'
sleep 2s
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
if [[ -n $YUM_CMD ]]; then
    sudo yum -y update
    echo '*********************************************'
    echo 'Instalando paquetes' 
    sleep 2s
    sudo yum -y upgrade
    sleep 2s
    echo 'Los paquetes han sido actualizados'
elif [[ -n $APT_GET_CMD ]]; then
    sudo apt-get update
    echo '*********************************************'
    echo 'Instalando paquetes'
    sleep 2s
    sudo apt-get -y upgrade
    sleep 2s
    echo 'Los paquetes han sido actualizados'
else
    echo "error can't update package cache"
    exit 1;
fi
