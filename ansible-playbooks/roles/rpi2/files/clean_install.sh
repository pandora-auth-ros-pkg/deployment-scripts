#!/bin/bash
PACKAGES=( 'git' 'openssh-server' 'vim' 'g++' 'cmake' 'build-essential' 'python-pip' )

NUM_PACKAGES=${#PACKAGES[@]}

echo -e "\033[01;32mInstalling packages\033[0m"
echo -e "Number of packages --> ${#PACKAGES[@]}"

echo -e "--------------------------------------"

COUNT=0
for elements in ${PACKAGES[@]}
do
  echo -e "\033[0;32m$COUNT] $elements\033[0m"
  sudo apt-get install -y $elements
  COUNT=$(( $COUNT + 1 ))
done
echo -e "\033[0m"

#=============================================================================
PYMOD=( 'RPi.GPIO' 'picamera' )

NUM_PYMOD=${#PYMOD[@]}
echo -e "\033[1;32mInstalling python packages\033[0m"
COUNT=0
for elements in ${PYMOD[@]}
do
  echo -e "\033[0;32m$COUNT] $elements\033[0m"
  sudo pip install $elements
  COUNT=$(( $COUNT + 1 ))
done
echo -e "\033[0m"


echo -e "\033[1;32mInstalling raspi-update\033[0m"
sudo curl -L --output /usr/bin/rpi-update https://raw.githubusercontent.com/Hexxeh/rpi-update/master/rpi-update && sudo chmod +x /usr/bin/rpi-update
