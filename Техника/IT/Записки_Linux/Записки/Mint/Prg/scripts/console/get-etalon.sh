# Получить содержимое файла-эталона
# Ввести как параметр имя файла-эталона

# Например
# cd /usr/local/sbin/consoleusers/
# bash get-etalon.sh /inRam/keys/key-a1-root

# Теперь в директории /usr/local/sbin/consoleusers/
# будет в наличии файл key-a1-root.etalon

etalon=`basename $1`.etalon

sha512sum $1 | egrep -io '^[a-f0-9]+' > $etalon
chmod a-rwx $etalon
