#!/bin/bash

CURRENT_DEVICES=`ls /dev`

device_list[0]='dynamixel'
device_list[1]='ahrs imu'
device_list[2]='hokuyo'
device_list[3]='arm'
device_list[4]='left_camera'
device_list[5]='right_camera'
device_list[6]='linear'
device_list[7]='epos2'
device_list[8]='xtion'
device_list[9]='pixy'

echo "${device_list[7]}"8

for device in ${device_list[*]}; do
  found='[ ]\033[0;31m'
  for current_device in $CURRENT_DEVICES; do
    if [ $device == $current_device ]; then
      found='[\033[0;34mX\033[0m]\033[1;32m'
      break
    fi
  done
  echo -e "${found} ${device}\033[0m"
done
