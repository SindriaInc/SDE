#!/bin/sh


# Install app
cd /var/www/$1/prod
php artisan migrate:fresh