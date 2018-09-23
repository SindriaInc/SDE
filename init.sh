#!/bin/sh

echo "Setup environment..."

KEY_PATH=$HOME/.sindria
FILE="$KEY_PATH/check"

mkdir -p $HOME/.ssh
mkdir -p $HOME/.sindria
sudo chmod 700 $HOME/.ssh
sudo chmod 755 $KEY_PATH
sudo chmod 600 $HOME/.ssh/*
sudo chmod +r $HOME/.ssh/*.pub
sudo chown -R ${whoami}:${whoami} $KEY_PATH

if [ -e "$FILE" ]; then
  echo "KEY already created. SKIP"
  #exit 1
else
  echo "Setup key..."
  echo #
  ssh-keygen -t rsa -N "" -f vagrant@dev
  sudo mv vagrant@* $KEY_PATH
  sudo chmod 755 $KEY_PATH
  sudo chmod 600 $KEY_PATH/*
  sudo chmod +r $KEY_PATH/*.pub
  sudo chown -R ${whoami}:${whoami} $KEY_PATH
  touch $KEY_PATH/check
fi

echo "Done."
