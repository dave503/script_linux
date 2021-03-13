#!/bin/bash

echo Verificar el nombre del servidor ---------

hostnamectl

echo ---------------------------------------------------
sleep 3s

echo Cambiando nombre del servidor ----------
echo ----------------------
read -p "Nuevo nombre del servidor: " nombre_server
sleep 3s
hostnamectl set-hostname $nombre_server
echo --Nuevo nombre del server--
hostnamectl
echo " "
echo ---------------------------------------------------

sleep 3s

echo Instalando herramientas de red ---------

sudo apt -y install net-tools

echo ---------------------------------------------------

sleep 3s

echo Instalando servicio de DNS --------------
sleep 2s
echo Actualizando paquetes -------------------
sudo apt update
sleep 3s
echo Instalando paquetes ---------------------
sudo apt upgrade
sleep 3s

echo Instalando bind9 ------------------------

sudo apt-get -y install bind9 bind9utils

sleep 3s

echo Verificar el contenido de la carpeta bind -

sudo chmod -R 777 /etc/bind/

sudo ls /etc/bind
echo " "
echo ------------------------------------------------
echo " "
echo Configurando zona del DNS
sleep 5s
echo Ingrese la raiz de la zona:
read -p "Raiz de la zona para DNS: " root_zona
echo  " "
echo Estas son las IP que tienen los adaptadores
ifconfig
echo " "
echo Ingrese los primeros 3 octetos de la IP que desea configurar, por ejemplo: 0.168.192 para 192.168.0.X
read -p "Fragamento de IP inversa: " ip_tres


echo "
// zona directa

zone '"$root_zona"' IN {
type master;
file '"/etc/bind/db.$root_zona"';
};

// zona inversa

zone '"$ip_tres.in-addr.arpa"' IN {
type master;
file '"/etc/bind/db.$ip_tres"';
};" >> /etc/bind/named.conf.local

sudo sudo cat /etc/bind/named.conf.local

echo ------------------------------------------------

sudo cp /etc/bind/db.local /etc/bind/db.$root_zona

sudo sudo cat /etc/bind/db.$root_zona

echo ------------------------------------------------
echo " "
ifconfig
echo " "
read -p "Ingrese la IP que tendra el servidor DNS: " ip_server

sudo sed -i "12,14d" /etc/bind/db.$root_zona

sudo sed -i "s/localhost/$nombre_server/g" /etc/bind/db.$root_zona
echo " "
echo "
@   IN  NS  $nombre_server
@   IN  A   $ip_server
server   IN  A   $ip_server
host   IN  A   $ip_server
client   IN  A   $ip_server
www   IN  A   $ip_server
" >> /etc/bind/db.$root_zona

echo ---------------------------------------------------
sudo cat /etc/bind/db.$root_zona
echo --------------------------------------------------
echo " "
sudo cp /etc/bind/db.127 /etc/bind/db.$ip_tres
echo
sudo sed -i "12,13d" /etc/bind/db.$ip_tres

sudo sed -i "s/localhost/$root_zona/g" /etc/bind/db.$ip_tres
echo " "
echo "
@   IN  NS  $nombre_server
@   IN  PTR   $root_zona
server   IN  A   $ip_server
host   IN  A   $ip_server
client   IN  A   $ip_server
www   IN  A   $ip_server
15  IN  PTR  $nombre_server
15  IN  PTR  client.$root_zona
 ">> /etc/bind/db.$root_zona
echo " "
sudo sudo cat /etc/bind/db.$root_zona
echo --------------------------------------------------
echo " "
echo Verificar la configuración del archivo named.conf ---
sudo named-checkconf -z /etc/bind/named.conf
echo 
echo Verificar la configuración del archivo named.conf.local
sudo named-checkconf -z /etc/bind/named.conf.local
echo " "
echo Verificar la configuración de la zona directa -----
named-checkzone $root_zona /etc/bind/db.$root_zona
echo " "
echo Verificar la configuración de la zona inversa -----
named-checkzone $root_zona /etc/bind/db.$ip_tres
echo " "
echo Iniciando el servidor------------------------------
sudo systemctl start bind9
sleep 5s
echo " "
echo Estado del servidor--------------------------------
sudo systemctl status bind9
echo " "
sleep 5s
echo ----Fin---- 
echo ---- © ServiCod 2021 -----------------------------


