#!/bin/bash

echo Actualizando paquetes

sleep 2s

sudo apt-get update

echo Instalando paquetes 

sleep 2s

sudo apt-get -y upgrade

sleep 2s

echo Los paquetes han sido actualizados
