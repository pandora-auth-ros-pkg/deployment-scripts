#!/bin/sh

cd $1
sudo rosdep install --from-paths src --ignore-src --rosdistro hydro -y
