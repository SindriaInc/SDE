#!/bin/sh

BIN=/bin/php
CONF=/etc/php/php72

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum install yum-utils -y
sudo yum-config-manager --enable remi-php72
sudo yum update -y
sudo yum install php72 -y
sudo yum install -y php72-php-xml \
	php72-php-soap \
	php72-php-pecl-xdebug \
	php72-php-pecl-ssh2 \
	php72-php-pecl-psr \
	php72-php-pecl-oauth \
	php72-php-pecl-mysql \
	php72-php-pecl-mcrypt \
	php72-php-pecl-http \
	php72-php-pecl-env \
	php72-php-pdo \
	php72-php-opcache \
	php72-php-mysqlnd \
	php72-php-mbstring \
	php72-php-json \
	php72-php-imap \
	php72-php-gd \
	php72-php-fpm \
	php72-php-devel \
	php72-php-dbg \
	php72-php-common \
	php72-php-cli \
	php72-php-bcmath


sudo systemctl start php72-php-fpm
cp /var/www/$1/scripts/templates/www.conf /etc/opt/remi/php72/php-fpm.d/
mkdir -p /etc/php


if [ ! -h "$BIN" ]; then
	sudo ln -s /bin/php72 /bin/php
fi


if [ ! -h "$CONF" ] && [ ! -d "$CONF" ]; then
	sudo ln -s /etc/opt/remi/php72 /etc/php/php72
fi

# Install composer
sudo yum install composer -y

#mv /etc/php.ini /etc/php.ini.old
#mv /etc/php.d /etc/php.d.old
#sudo ln -s /etc/opt/remi/php72/php.d/ /etc/php.d
#mv /usr/lib64/php/modules /usr/lib64/php/modules.old
#sudo ln -s /opt/remi/php72/root/usr/lib64/php/modules /usr/lib64/php/modules

