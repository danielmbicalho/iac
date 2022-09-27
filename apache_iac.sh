#!/usr/bin/bash

apt update 
apt upgrade -y
apt install -y apache2 unzip
curl -LO https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -O /tmp
cp -r /tmp/linux-site-dio-main/ /var/www/html/