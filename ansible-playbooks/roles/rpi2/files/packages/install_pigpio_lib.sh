#!/bin/bash

colors ()
{
  RESET='\e[0m'
  BLACK='\e[1;30m'
  RED='\e[1;31m'
  GREEN='\e[1;32m'
  YELLOW='\e[1;33m'
  BLUE='\e[1;34m'
  PURPLE='\e[1;35m'
  CYAN='\e[1;36m'
  WHITE='\e[1;37m'
}; colors


cd ~
if [ -d "~/PIGPIO" ]; then
  rm -rf ~/.PIGPIO
fi

echo -e "${BLUE}Fetching pigpio sources...${RESET}" 
echo -e "`wget abyz.co.uk/rpi/pigpio/pigpio.zip`"
echo -e "`dpkg -s unzip 2>/dev/null >/dev/null || sudo apt-get install -y unzip`"
cd PIGPIO && make && sudo make install 

