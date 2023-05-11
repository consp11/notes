#!/usr/bin/bash
# sudo /media/veracrypt1/unmount.sh
# sudo veracrypt -l

sudo -v

if [ -z "$1" ]
then
    SL=5
	CNT=11
else
	SL=0
	CNT=0
fi

# Закрываем окна приложений
Thunar -q &>> /dev/null
wmctrl -c "Opera"      &>> /dev/null
wmctrl -c "FireFox"     &>> /dev/null
wmctrl -c "Notepadqq"    &>> /dev/null

sudo killall -q -u first
sudo killall -q -u dev
sudo killall -q -u game
sudo killall -q -u gamecommand
sudo killall -q -u inet
sudo killall -q -u opera
sudo killall -q -u deluge
sudo killall -q -u quite-rss
sudo killall -q -u tor-browser
sudo killall -q -u chromium
sudo killall -q -u mega



# Старые пользователи
#sudo killall -q -u g
#sudo killall -q -u g2
#sudo killall -q -u br1
sudo killall -q -I Thunar

sudo killall -q -I notepadqq-bin

sudo veracrypt -t -d --force

sudo swapoff -av &
# sudo sdel ndd /var/log

wait

sudo sdel vvpr /Arcs/swapfile*

EV=0

sudo veracrypt -t -d --force

# Если произошла ошибка
if [ $? -ne 0 ]; then
	SL=$(($SL+$CNT))
    EV=1
fi

# 033[41m - это цвета

# Выводим результат выполнения
# Считаем количество swap-файлов
CS=`sudo swapon | wc -l`

echo 
if [ $CS -eq 0  ]; then
	echo -e "\033[32mswap-файлы отключены\033[0m"
else
	echo -e "\033[04;41mПодключёных swap-файлов: $CS\033[0m"
	SL=$(($SL+$CNT))
fi

echo
CD=`sudo veracrypt -t -l | wc -l`
if [ $CD -eq 0  ]; then
	echo -e "\033[32mВсе диски отключены\033[0m"
else
	echo -e "\033[04;41mПодключёных дисков: $CD\033[0m"
	SL=$(($SL+$CNT))
fi

echo


echo

if [ $EV -ne 0 ]; then
    sleep 7
    sudo veracrypt -t -d --force &
    disown -a
fi

i=$SL
while [ $i -gt 0 ]
do
	tput sc
	# Сохраняем позицию курсора. После вывода возвращаем курсор назад
	# Пробел в конце нужен, чтобы при затереть "д" от более длинных строк
	# (когда i = 9 длина строки уменьшается на единицу по сравнению с i = 10)
	echo -en "\033[0mЗавершение через $i секунд "
	i=$(($i-1))
	sleep 1
	tput rc
done

echo
