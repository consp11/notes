#!/bin/bash

sudo apt-get update -y &>> /inRam-Logs/upgrade
sudo apt-get -y --with-new-pkgs --fix-broken upgrade &>> /inRam-Logs/upgrade

if [[ $? -ne 0 ]]
then
sudo apt-get -y --with-new-pkgs --fix-broken upgrade &>> /inRam-Logs/upgrade
fi

sudo apt-get autoremove &>> /inRam-Logs/upgrade
sudo apt-get autoclean &>> /inRam-Logs/upgrade

