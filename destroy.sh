#!/bin/sh

vagrant destroy -f
rm -rf .vagrant/
sed -i -e "s/wsl: true/wsl: false/g" sindria.yml
echo "Done."

