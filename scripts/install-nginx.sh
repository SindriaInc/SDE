#!/bin/sh


sudo yum install nginx -y
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled
sudo mkdir -p /var/log/nginx/$1
sudo touch /var/log/nginx/$1/access.log
sudo touch /var/log/nginx/$1/error.log
sudo cp /var/www/$1/scripts/templates/nginx.conf /etc/nginx/

