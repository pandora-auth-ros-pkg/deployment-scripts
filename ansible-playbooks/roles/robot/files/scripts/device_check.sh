#!/bin/bash

# Store command line arguments
DEVICE_LIST=$1

CONNECTED_DEVICES=`ls /dev``arp | awk '{print $1}' | xargs`
HEADER1="Category"
HEADER2="Devices"


# Bold color list
colors ()
{
  RESET='\e[0m'
  BLACK='\e[1;30m'
  BOIBLACK='\e[1;100m'
  RED='\e[1;31m'
  GREEN='\e[1;32m'
  YELLOW='\e[1;33m'
  BLUE='\e[1;34m'
  PURPLE='\e[1;35m'
  CYAN='\e[1;36m'
  WHITE='\e[1;37m'
}; colors

# Stores the max string length of device category in $max
max_name_length ()
{
  MAX_N=${#HEADER1}

  local device_row
  while read device_row; do
    if [ "${device_row:0:1}" == "#" ]; then
      continue
    fi

    local word
    local word_length
    for word in $device_row; do
      word_length=${#word}
      if [ "${word:0:1}" == "[" ] && (( "${word_length}" > "${MAX_N}" )); then
        MAX_N=$word_length
      fi
    done
  done <$DEVICE_LIST
}

# Main function
device_check ()
{
  echo -n "  "

  max_name_length

  local n

  # Add header
  local header1_length=${#HEADER1}
  echo -en "${BOIBLACK}${HEADER1}${RESET}"
  for ((n=0; n<=((MAX_N-header1_length+2)); n++)); do
    echo -n " "
  done
  echo -e "${BOIBLACK}${HEADER2}${RESET}"

  local device_long_row
  while read device_long_row; do
    # Ignore rows starting with "#"
    if [ "${device_long_row:0:1}" == "#" ]; then
      continue
    fi

    echo -n "  "

    # Seperate and echo words starting with "["
    local device_row=""
    local word
    local category_length=""
    for word in $device_long_row; do
      if [ "${word:0:1}" == "[" ]
        then
          echo -en "${BLUE}${word}${RESET}"
          category_length=${#word}
        else
          device_row="${device_row} ${word}"
      fi
    done

    # Adjust spaces
    for ((n=0; n<=((MAX_N-category_length+1)); n++)); do
      echo -n " "
    done

    local device_found
    local device_print=""

    # Check if the device is equal to any of the current devices
    local device
    for device in $device_row; do
      device_found=false

      local connected_device
      for connected_device in $CONNECTED_DEVICES; do
        if [ $device == $connected_device ]; then
          device_found=true
          device_print="${device_print} ${GREEN}${device}${RESET}"
          break
        fi
      done

      if [ "${device_found}" == false ]; then
        device_print="${device_print} ${RED}${device}${RESET}"
      fi
    done

    echo -e "${device_print}${RESET}"
  done <$DEVICE_LIST
}; device_check
