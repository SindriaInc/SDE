#!/bin/sh

# Enable php
sudo systemctl restart php72-php-fpm
sudo systemctl enable php72-php-fpm
sudo systemctl status php72-php-fpm

# Enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

# Enable mariadb
sudo systemctl restart mariadb
sudo systemctl enable mariadb
sudo systemctl status mariadb

# Enable docker
sudo systemctl restart docker
sudo systemctl enable docker
sudo systemctl status docker
