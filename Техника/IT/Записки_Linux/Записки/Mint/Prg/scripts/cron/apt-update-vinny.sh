#!/bin/bash

function waitPing(i)
{
    # Ожидаем появления интернета
    ping -s 16 -c 1 77.88.8.88 >> /dev/null
    while [[ $? -ne 0 && $i -gt 0 ]]
    do
      sleep 5
      i=$(($i-1))
      ping -s 16 -c 1 77.88.8.88 >> /dev/null
    done

    ping -s 16 -c 1 77.88.8.88 &>> /inRam-Logs/upgrade
}

echo -e "\n\n\n" &>> /inRam-Logs/upgrade
date &>> /inRam-Logs/upgrade
waitPing 1000

date &>> /inRam-Logs/upgrade
sudo apt-get update -y &>> /inRam-Logs/upgrade
sudo apt-get -y --with-new-pkgs --fix-broken upgrade &>> /inRam-Logs/upgrade

if [[ $? -ne 0 ]]
then
waitPing 100

date &>> /inRam-Logs/upgrade
sudo apt-get -y --with-new-pkgs --fix-broken upgrade &>> /inRam-Logs/upgrade
fi

sudo apt-get -y autoremove &>> /inRam-Logs/upgrade
# sudo apt-get autoclean &>> /inRam-Logs/upgrade

