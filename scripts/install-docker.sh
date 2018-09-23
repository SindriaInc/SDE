#!/bin/sh

APPS=/apps

# Add docker group
sudo groupadd docker


# Add vagrant user to docker group
sudo usermod -aG docker vagrant


# Fix vagrant uid for docker container
#sudo usermod -u 1004 vagrant

# Install docker
wget -qO- https://get.docker.com/ | sh
sudo systemctl start docker


# Install docker-compose
yum install -y python-pip
pip install docker-compose
yum upgrade python*
docker-compose -v

# Create symlink apps
if [ ! -h "$APPS" ] && [ ! -d "$APPS" ]; then
	sudo ln -s /var/www/$1/apps /apps
fi
