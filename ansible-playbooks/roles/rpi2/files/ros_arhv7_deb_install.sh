#!/bin/bash


if [ $(dpkg-query -W -f='${Status}' nano 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  echo -e "\033[1;32mInstalling ROS...\033[0m"
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
  wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install -y ros-indigo-ros-base

  echo -e "\033[1;32mConfiguring ROS\033[0m"
  sudo apt-get install -y python-rosdep
  sudo rosdep init
  rosdep update
  #-- Updating sorces list is required before installation of python-rosinstall
  sudo apt-get update
  sudo apt-get install -y python-rosinstall
else
  echo -e "\033[1;34mROS already installed on the system\033[0m"
fi
