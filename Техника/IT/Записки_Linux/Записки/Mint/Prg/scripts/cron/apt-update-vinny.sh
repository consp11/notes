#!/bin/bash

sudo apt-get update -y
sudo apt-get -y --with-new-pkgs --fix-broken upgrade

if [[ $? -ne 0 ]]
then
sudo apt-get -y --with-new-pkgs --fix-broken upgrade
fi

sudo apt-get autoremove
sudo apt-get autoclean

