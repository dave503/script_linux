#!/bin/bash

sudo sudo cat /etc/bind/db.$root_zona

echo ------------------------------------------------
echo " "
ifconfig
echo " "
read -p "Ingrese la IP que tendra el servidor DNS: " ip_server

sudo sed -i "12,14d" /etc/bind/db.$root_zona

sudo sed -i "s/localhost/$nombre_server/g" /etc/bind/db.$root_zona
echo " "
sudo sudo cat /etc/bind/db.$root_zona

echo sudo "
@   IN  NS  $nombre_server
@   IN  A   $ip_server
server   IN  A   $ip_server
host   IN  A   $ip_server
client   IN  A   $ip_server
www   IN  A   $ip_server
" >> /etc/bind/db.$root_zona

sudo sudo cat /etc/bind/db.$root_zona
