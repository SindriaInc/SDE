#!/bin/sh

sed -i -e "s/wsl: false/wsl: true/g" /var/www/$1/sindria.yml


echo "All Done."
echo #
echo "You can run vagrant ssh and test it at http://$1"
