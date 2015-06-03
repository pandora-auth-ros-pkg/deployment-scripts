#!/bin/bash

if [ -x /usr/local/bin/device_check.sh ]; then
  echo
  /usr/local/bin/device_check.sh ~/.device_list
  echo
fi

if [ -x /usr/local/bin/repo_status.sh ]; then
  # echo
  # /usr/local/bin/repo_status.sh ~/pandora_ws/src hydro-devel master
  # echo
  :
fi

