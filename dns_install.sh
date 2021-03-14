#!/bin/bash

echo Verificar el nombre del servidor ---------

hostnamectl

echo ---------------------------------------------------

echo Cambiando nombre del servidor ----------
echo ----------------------
read -p "Nuevo nombre del servidor: " nombre_server

hostnamectl set-hostname $nombre_server
echo --Nuevo nombre del server--
hostnamectl
echo " "
echo ---------------------------------------------------

echo Instalando herramientas de red ---------

sudo apt -y install net-tools

echo ---------------------------------------------------

echo Instalando servicio de DNS --------------

echo Actualizando paquetes -------------------

sudo apt update

echo Instalando paquetes ---------------------

sudo apt upgrade

echo Instalando bind9 ------------------------

sudo apt-get -y install bind9 bind9utils

echo Verificar el contenido de la carpeta bind -

sudo chmod -R 777 /etc/bind/

sudo ls /etc/bind/

echo ------------------------------------------------

echo Configurando zona del DNS

echo Ingrese la raiz de la zona:
read -p "Raiz de la zona para DNS: " root_zona

echo Estas son las IP que tienen los adaptadores

ifconfig

echo Ingrese los primeros 3 octetos de la IP que desea configurar, por ejemplo: 0.168.192 para 192.168.0.X

read -p "Fragamento de IP inversa: " ip_tres

echo '
// zona directa

zone "'$root_zona'" IN {
type master;
file "/etc/bind/db.'$root_zona'";
};' >> /etc/bind/named.conf.local
echo '
// zona inversa

zone "'$ip_tres'.in-addr.arpa" IN {
type master;
file "/etc/bind/db.'$ip_tres'";
};' >> /etc/bind/named.conf.local

sudo cat /etc/bind/named.conf.local

echo ------------------------------------------------

sudo cp /etc/bind/db.local /etc/bind/db.$root_zona

sudo cat /etc/bind/db.$root_zona

sudo chmod -R 777 /etc/bind/

echo ------------------------------------------------

ifconfig

read -p "Ingrese la IP que tendra el servidor DNS: " ip_server

sudo sed -i "12,14d" /etc/bind/db.$root_zona

sudo sed -i "s/localhost/$nombre_server/g" /etc/bind/db.$root_zona

echo "
@       IN  NS  $nombre_server.
@       IN  A   $ip_server
server  IN  A   $ip_server
host    IN  A   $ip_server
client  IN  A   $ip_server
www     IN  A   $ip_server
" >> /etc/bind/db.$root_zona

echo ---------------------------------------------------
sudo cat /etc/bind/db.$root_zona
echo --------------------------------------------------

sudo cp /etc/bind/db.127 /etc/bind/db.$ip_tres

sudo sed -i "12,13d" /etc/bind/db.$ip_tres

sudo sed -i "s/localhost/$root_zona/g" /etc/bind/db.$ip_tres

sudo chmod -R 777 /etc/bind/

echo "
@       IN  NS   $nombre_server.
@       IN  PTR  $root_zona
server  IN  A    $ip_server
host    IN  A    $ip_server
client  IN  A    $ip_server
www     IN  A    $ip_server
15      IN  PTR  $nombre_server
15      IN  PTR  client.$root_zona
" >> /etc/bind/db.$ip_tres

sudo sudo cat /etc/bind/db.$ip_tres

echo --------------------------------------------------

echo Verificar la configuración del archivo named.conf ---

sudo named-checkconf -z /etc/bind/named.conf
 
echo Verificar la configuración del archivo named.conf.local

sudo named-checkconf -z /etc/bind/named.conf.local

echo Verificar la configuración de la zona directa -----

named-checkzone $root_zona /etc/bind/db.$root_zona

echo Verificar la configuración de la zona inversa -----

named-checkzone $root_zona /etc/bind/db.$ip_tres


sudo cat /etc/default/named

sudo chmod -R 777 /etc/default/

echo ---------------------------------------------------

echo "Configurando servidor, solo para IPv4"

sudo sed -i "6d" /etc/default/named

echo 'OPTIONS="-u bind -4"' >> /etc/default/named

sudo cat /etc/default/named

echo ------------------------------------------------
echo Iniciando el servidor------------------------------

sudo systemctl start bind9

echo Estado del servidor--------------------------------

sudo systemctl status bind9

echo         ----Fin---- 
echo ---- © ServiCod 2021 -----------------------------


