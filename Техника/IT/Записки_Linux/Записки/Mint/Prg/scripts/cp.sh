#mkdir /inRam/--
#cp -fvu /media/veracrypt1/Пароли/*.key /inRam/--
#cp -fvu /media/veracrypt1/emails/*.key /inRam/--


# Копируем для обновлений диск с ключами key
# cp -fvu /Arcs/Big/Crypto/keys /Arcs/Repos/consp11.github.io/data/irrelevant
# cp -fvu /Arcs/Big/Crypto/keys /Arcs/Disks/Mega/MEGAsync/Keys/
cp -fvu /Arcs/Big/Crypto/keys-main /Arcs/Disks/Mega/MEGAsync/Keys/
cp -fvu /Arcs/Big/Crypto/keys-var /Arcs/Disks/Mega/MEGAsync/Keys/


# Обновляем резервные копии скриптов в Mega
cp -fvu /media/veracrypt1/*.sh /A/_/Linux_Записки_Prg/scripts/
cp -fvu /media/veracrypt8/*.sh /A/_/Linux_Записки_Prg/scripts/
# Это делаем отдельно после монтирования
#cp -fvu /home/main/bin/*.sh    /home/a1/_/Linux_Записки_Prg/scripts/exec


# Копируем всё в https://github.com/fdsc/reserve
# cp -fvu /Arcs/Big/Crypto/keys /Arcs/Repos/reserve/
cp -fvu /Arcs/Big/Crypto/keys-main /Arcs/Repos/reserve/
cp -fvu /Arcs/Big/Crypto/keys-var /Arcs/Repos/reserve/
cp -fvu /Arcs/Big/Crypto/disks/Literature-2 /Arcs/Repos/reserve/
cp -fvu /Arcs/Big/Crypto/disks/Plans-2 /Arcs/Repos/reserve/

# Дополнительно копируем нужные вещи в Mega
cp -fvu /Arcs/Big/Crypto/disks/Literature-2  /Arcs/Disks/Mega/MEGAsync/Keys/
cp -fvu /Arcs/Big/Crypto/disks/Plans-2  /Arcs/Disks/Mega/MEGAsync/Keys/


# dt=`date --rfc-3339=date`
# 7z a -y -t7z -m0=lzma -mx=0 -bb0 -bd -ssc -ssw -mhe=on -pPASSWORD /Arcs/Repos/reserve/keys-$dt.7z /Arcs/Disks/ya/Ключи/Первичные/

pt=`pwd`
cd /Arcs/Repos/reserve/

# Создаём архив актуальных первичных ключей
# На всякий случай, для начала копируем все bdc-файлы внутрь первичных ключей
cp -fvu /Arcs/Disks/ya/*.bdc /Arcs/Disks/ya/Ключи/Первичные/

7z a -y -t7z -m0=lzma2 -mx=0 -bb0 -bd -ssc -ssw /Arcs/Repos/reserve/keys-primary.7z /Arcs/Disks/ya/Ключи/Первичные/  > /dev/null

# Добавляем в него файл keysreserve.txt
7z a -y -t7z -m0=lzma2 -mx=0 -bb0 -bd -ssc -ssw /Arcs/Repos/reserve/keys-primary.7z /Arcs/Disks/Mega/MEGAsync/Keys/keysreserve.txt  > /dev/null

# Копируем архив в другие места
cp -fvu /Arcs/Repos/reserve/keys-primary.7z /Arcs/Disks/Mega/MEGAsync/Keys/keys-primary.7z
cp -fvu /Arcs/Repos/reserve/keys-primary.7z /Arcs/Repos/consp11.github.io/data/irrelevant/keys-primary.7z
cp -fvu /Arcs/Repos/reserve/keys-primary.7z /Arcs/Disks/ya/Ключи/key_disk/

# 7z u -y -t7z -stl -m0=lzma -mx=9 -ms=on -bb0 -bd -ssc -ssw

# Копируем записки Linux на всякий случай, чтобы они все были под рукой
# 7z u -y -t7z -stl -uq0x1y2z1w2 -m0=lzma -mx=9 -ms=on -bb0 -bd -ssc -ssw -pc5E70ryYD3mkkqoVZWoSWD8kpAaixxhw -mhe /Arcs/Repos/reserve/Linux_Записки.7z /home/vinny/_/Linux_Записки/

# Копируем записки Linux в notes
cp -rfvu /Arcs/Disks/Mega/MEGAsync/Записки /A/notes/Техника/IT/Записки_Linux/
chmod -Rf g+rwX /A/notes/Техника/IT/Записки_Linux/Записки/

## Работа с borg
#echo -e '\n\nbegin of borg section\n'
#cp -fu /media/veracrypt8/Reserve/borg-sh.key /home/a1/.config/borg/keys

## borg delete --stats /Arcs/Repos/reserve/borg/::LinuxRecords
#export BORG_PASSCOMMAND="cat /home/a1/_/keys-var/Reserve/borg-sh.pass"
## borg delete -a 'LinuxRecords*' --first 1 /Arcs/Repos/reserve/borg/
## --stats LinuxRecords-{now}
##  --noatime - уже по умолчанию флаг стоит
#borg create -e '*/.debris/*' --compression auto,lzma,9 /Arcs/Repos/reserve/borg/::LinuxRecords-{now} '/Arcs/Disks/Mega/MEGAsync/Записки'
## borg create --noatime -e 'rss' --compression none /Arcs/Repos/reserve/borg/::Disks-{now} '/Arcs/Big/Crypto/disks/'

#sdel - /home/a1/.config/borg/keys/borg-sh.key > /dev/null

#echo -e '\nend of borg section\n\n'


cp -rfvu /Arcs/Big/Crypto/ /A/Ya-disk/
cp -rfvu /Arcs/Big/books/  /A/Ya-disk/Arcs/


disown -a

cd $pt
