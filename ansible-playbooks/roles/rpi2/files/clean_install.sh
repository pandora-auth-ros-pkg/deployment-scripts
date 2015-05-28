#!/bin/bash
PACKAGES=( 'git' 'openssh-server' 'vim' 'ros-indigo-' )

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
