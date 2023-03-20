#!/usr/bin/bash
# xfce4-terminal -x %1
# Вызывать с параметром типа swap.sh 2G


# sudo echo "Подключение swap-файла"

# ----------------------------------------------------------------
# Подключаем swap
# Перед подключением swap не должно быть &, иначе он подключит диск раньше, чем он смонтируется
# sudo swapon -v /dev/loop1

size=$1

if [ -z "$size" ]
then
    size=2G
fi

sudo swapoff /Arcs/swapfile
sudo /G/sdel prv /Arcs/swapfile

sudo fallocate -l $size /Arcs/swapfile
sudo chmod 0600 /Arcs/swapfile
sudo mkswap /Arcs/swapfile
sudo swapon -v /Arcs/swapfile

