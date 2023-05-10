# Виноградов С.В.
# Команда проверяет, что введён правильный ключевой файл и он соответствует эталону
# Эталон содержит лишь хеш ключевого файла
# Файл-эталон должен храниться в системной директории так, чтобы быть недоступным к перезаписи
# Читать файлы-эталоны может кто угодно
# Вспомогательные скрипты также могут читать дополнительный пароль с помощью read -s password_var
# После запуска скрипта, пользователь должен вручную переместить пароль из файла outFileName в файл inFileName
# Перемещение из одного файла в другой можно делать из-под другого пользователя. Причём, не обязательно админа, т.к. можно прописать правила sudoedit в sudoers
# Четвёртый параметр даёт возможность зайти без пароля
# Данный скрипт не должен вызываться напрямую, т.к. nopwd должен быть установлен доверенным скриптом
# Таким образом, вызов скрипта не должен быть разрешён в sudoers, это нужно делать для скриптов, которые вызывают этот

lecturesDir='/A/notes/Мусор/sudo_lectures/'
dirName='/inRam/consoleuser/'
mkdir -p $dirName
if [[ $? -eq 0 ]]
then
    chmod a-rwx $dirName
fi

 inFileName="$dirName/in"
outFileName="$dirName/out"

 inFileName=`realpath $inFileName`
outFileName=`realpath $outFileName`


lockDir=`realpath "$dirName/consoleuser.lock"`


touch "$inFileName"
touch "$outFileName"

chmod a-rwx "$inFileName"
chmod a-rwx "$outFileName"


if [[ -z $1 || -z $2 ]]
then
    echo 'bash consoleuser.sh etalon_file key_file'
    echo 'bash consoleuser.sh etalon_file key_file userName'
    echo 'bash consoleuser.sh etalon_file key_file userName pwd'
    echo 'bash consoleuser.sh etalon_file key_file userName nopwd'
    exit
fi

if [[ ! -a $1 ]]
then
    echo 'No have etalon file'
    exit
fi

if [[ ! -a $2 ]]
then
    echo 'The key file not exists'
    exit
fi

# Работаем с временным паролем, если он должен быть
if [[ $4 != 'nopwd' ]]
then

tty=`tty`
password=`apg -a 1 -n 1 -M ncl -m 24 -x 24`

dirofsh=`dirname "$0"`
dirofsh=`realpath "$dirofsh/consoleuser-apg.sh"`

str="\n\n"`date`"\n$tty\n$password"
flock "$outFileName" bash -i $dirofsh "$str" "$outFileName"

echo -e "\n"`date`"\n\nFrom $tty\nThe password writed\nsudoedit '$outFileName'\nLet's transport it to the file\nsudoedit '$inFileName'"



# Предварительно проверяем наличие нужного пароля
ttyList=`cat "$inFileName" | egrep "^$password\$" | wc -l`
while [[ $ttyList != '1' ]]
do
    sleep 2
    ttyList=`cat "$inFileName" | egrep "^$password\$" | wc -l`
done


cnt=7
mkdir lockDir
while [[ $? -ne 0 && $cnt -gt 0 ]]
do
    cnt=$(( $cnt-1  ))
    sleep $(( 4-$cnt/2 ))
    echo 'Fail to aquire lock. Try to aquire lock again'
    mkdir lockDir
done

if [[ $cnt -le 0 ]]
then
    echo 'Can not aquire lock (internal script error)'
    exit
elif [[ $cnt -le 6 ]]
then
    echo 'Aquire success. Continue...'
fi

# Проверяем наличие нужного пароля
ttyList=`cat "$inFileName" | egrep "^$password\$" | wc -l`

if [[ $ttyList != '1' ]]
then

    echo -e "No have a current temporary password in '$inFileName'. Let's place the temporary password in the file: one name by line (apg -a 1 -n 1 -M ncl -m 16 -x 16 > $inFileName)"

    rmdir lockDir
    exit
fi

# Удаляем временный пароль
# truncate -s 0 "$inFileName"
# echo "l1\nl2\nl3\nl4\nl5" > "$inFileName"

output=`cat "$inFileName" | egrep -v "^$password\$"`
echo "$output" > "$inFileName"

rmdir lockDir

# Заканчиваем блок: "Работаем с паролем, если он должен быть"
fi


# --------------------------------------------------------------------
# Основной код: здесь проверяем основной пароль и передаём управление на консоль другого пользователя

user=$3
if [[ -z $3 ]]
then
    user='root'
fi


# HASH1=`sha512sum $1 | egrep -io '^[a-f0-9]+'`
HASH1=`cat $1`
HASH2=`sha512sum $2 | egrep -io '^[a-f0-9]+'`


if [[ $HASH1 != $HASH2 ]]
then
    echo -e "Permission denied: hash of '$2' is incorrect (for etalon '$1')"
    exit
fi

echo -e '\nSuccessfull\n'

# К сожалению, из-за того, что мы запускаем sudo из-под root, "лекция" нам точно не будет выведена
# Поэтому, выводим её сами
lectureFile=$lecturesDir/$user
if [[ -a "$lectureFile" ]]
then
    echo '----------------------------------------------------------------'
    cat "$lectureFile"
elif [[ -a "$lecturesDir/default" ]]
then
    echo '----------------------------------------------------------------'
    cat "$lecturesDir/default"
fi

sudo -u $user -i
