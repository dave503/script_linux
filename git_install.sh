#!/bin/bash

echo Actualizando repositorios

sleep 2s

sudo apt-get update

sleep 2s

echo Instalando Git

sudo apt-get -y install git

sleep 2s

echo Configurando variables globales

git config --global user.name "David Argueta"

git config --global user.email "davidargueta503m@gmail.com"

sleep 2s

echo Variables globales configuradas

echo ****************************************************

echo Verificar la version de Git

git --version

echo ****************************************************

echo Revisando la configuracion

git config --list

sleep 2s

echo Todo listo
