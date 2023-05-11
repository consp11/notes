# ----------------------------------------------------------------
# Записываем unmount.sh, чтобы было легче размонтировать потом всё. Обновляем end.sh
# cp -fvu /media/veracrypt8/unmount.sh /home/a1/_/unmount.sh
cp -fvu /media/veracrypt8/unmount.sh /usr/local/bin/


# cp -fvu /Arcs/Disks/Mega/MEGAsync/Записки/Mint/Prg/scripts/end.sh /usr/local/bin/
END_FILE_OR=/Arcs/Disks/Mega/MEGAsync/Записки/Mint/Prg/scripts/end.sh
END_FILE_CP=/usr/local/bin/
# cp -fv $END_FILE_OR $END_FILE_CP
echo -e "# ---------------- DO NOT CHANGE THE FILE ----------------\n# THIS IS A COPY OF FILE $END_FILE" > $END_FILE_CP/end.sh
# Дата копирования была удалена в связи с тем, что на неё каждый раз срабатывает AIDE
# echo -e "# date of copy: "  `date`  >> $END_FILE_CP/end.sh
echo -e "\n\n"  >> $END_FILE_CP/end.sh
cat $END_FILE_OR >> $END_FILE_CP/end.sh


# Копируем правила /etc/sudoers.d
cp -rfvu /etc/sudoers.d /Arcs/Disks/Mega/MEGAsync/Записки/Mint/Prg/scripts/sudoers.d

mkdir -p /usr/local/sbin/consoleusers/ --mode=a-rwx+t
setfacl -m d::--- /usr/local/sbin/consoleusers/

cp -rfvu /A/_/Linux_Записки_Prg/scripts/console/* /usr/local/sbin/consoleusers/
chmod a-rwx /usr/local/sbin/consoleusers/*
