#!/bin/bash

# Configure SPI interface
sudo groupadd spi # Create spi group

# RUN ONLY ONCE!!!!
sudo adduser pandora
sudo adduser pandora dialout # Serial devices (tty)
sudo adduser pandora sudo 
sudo adduser pandora video  # For video devices

