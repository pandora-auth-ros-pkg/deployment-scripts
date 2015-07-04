#!/bin/bash

MY_IP=$(ifconfig eth0 | grep "inet " | awk -F'[: ]+' '{ print $4 }')
export ROS_MASTER_URI=http://$MY_IP:11311
export ROS_IP=$MY_IP
export ROSLAUNCH_SSH_UNKNOWN=1

echo -e "ROS_MASTER_URI: $ROS_MASTER_URI"
echo -e "ROS_IP: $ROS_IP"



