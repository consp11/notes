#!/bin/bash
# sudo cp -fv /Arcs/Disks/Mega/MEGAsync/Записки/Mint/Prg/scripts/end.sh /usr/local/bin/
# /Arcs/Disks/Mega/MEGAsync/Privoxy/Privoxy/_ServicesFiles/logdelete.service

# также в ip1-service-remove
OF=/var/log/cleanup-vinny.log
dateOfBegin=`date`

echo "start $0"

killall -u a1 -u first -u dev -u game -u gamecommand -u inet -u opera -u chromium -u deluge -u quite-rss -u tor-browser -u mega -u yandex-disk -u vinny-proxy

veracrypt -t -d --force &
sdel ndd /var/log

echo "start $0" 	&>  $OF
echo $dateOfBegin   &>> $OF

#systemctl status sys-fs-fuse-connections.mount &>> $OF
#echo
#echo
#systemctl status &>> $OF
#ls -1 /sys/fs/fuse/ &>> $OF

echo -e "\n\n\n\n" 	&>> $OF

bash /usr/local/bin/unmount.sh 0 &>> $OF

echo -e "\n\nunmount ended\n\n"  &>> $OF

sdel v /Arcs/swapfile* 	&>> $OF
sdel ndd /run/log 		&>> $OF
sdel ndd /var/tmp 		&>> $OF

# Проверяем, что все диски отключены и только тогда начинаем перезаписывать /tmp
# Чтобы случайно не перезаписать диски veracrypt, находящиеся в /tmp
CD=`sudo veracrypt -t -l | wc -l`
if [ $CD -eq 0  ]; then
	sdel ndd /tmp 		 &>> $OF
else
	echo 'ERROR: veracrypt have mounted valumes' >> $OF
	sudo veracrypt -t -l &>> $OF
	
	echo  &>> $OF
	echo  &>> $OF
	echo  &>> $OF

	lsof  &>> $OF
	veracrypt -t -d --force &>> $OF
fi

umount -a 	&>> $OF

echo  &>> $OF
echo  &>> $OF
echo  &>> $OF

#echo '/proc/self/mountinfo' &>> $OF
#cat /proc/self/mountinfo 	&>> $OF

echo -e "\n\nEnd of $0\n" &>> $OF
date                      &>> $OF

exit 0
