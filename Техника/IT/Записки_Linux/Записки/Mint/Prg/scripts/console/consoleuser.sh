# Виноградов С.В.
# Команда проверяет, что введён правильный ключевой файл и он соответствует эталону
# После этого даёт пользователю консоль нужного пользователя
# Эталон содержит лишь хеш ключевого файла
# Файл-эталон должен храниться в системной директории так, чтобы быть недоступным к перезаписи
# Читать файлы-эталоны может кто угодно, хотя лучше их забанить и на чтение (chmod a-rwx)
# Вспомогательные скрипты также могут читать дополнительный пароль с помощью read -s password_var
# После запуска скрипта пользователем user1, пользователь user2 должен вручную переместить пароль из файла outFileName в файл inFileName
# Перемещение из одного файла в другой можно делать из-под непривилегированного пользователя, т.к. можно прописать правила sudoedit в sudoers
# При использовании sudoedit нужно соблюдать бдительность, т.к. он создаёт временный файл в директории /tmp
# А это значит, что одноразовый пароль может быть прочитан любым приложением, которое может быть запущено из-под пользователя user2 (группа значения уже не имеет, там стоят права rw-------)

# Данный скрипт не должен вызываться напрямую, т.к. параметр nopwd должен быть установлен доверенным скриптом, который не может быть изменён вызывающим пользователем
# Таким образом, вызов скрипта не должен быть разрешён в sudoers, это нужно делать для скриптов, которые вызывают этот скрипт

# Пример вызова скрипта из вспомогательного скрипта
# bash -i /usr/local/sbin/consoleusers/consoleuser.sh /usr/local/sbin/consoleusers/key-inet-ch.etalon /inRam/keys/key-inet-ch ch inet nopwd
# Первый параметр: путь к эталонному файлу для сравнения (содержит хеш ключевого файла, см. get-etalon.sh)
# Второй параметр: путь к ключевому файлу. Этот файл помещается в нужную директорию только тогда, когда необходима авторизация (либо размещается на флеш-памяти и подключается в момент авторизации)
# Третий параметр: имя пользователя, консоль которого мы хотим получить
# Четвёртый параметр: имя пользователя, который вызывает скрипт (нужно, чтобы сформировать файл одноразовых паролей)
# Пятый параметр: nopwd - говорит о том, что не нужно использовать одноразовые пароли. Параметр может быть пуст

# Для применения скрипта нужно подготовить вспомогательные скрипты.
# Изменить пути в скрипте на нужные (lecturesDir, dirName, inFileName, outFileName)
# Положить этот скрипт и вспомогательные в директорию, недоступную для изменения кем-либо  (chmod a-rwx; sudo chown root:root)
# Сформировать ключевой файл и удалить к нему доступ, если он положен на флешку или на veracrypt-том (chmod a-rwx; sudo chown root:root). Если он создаётся отдельно, см. ниже
# Сформировать во вспомогательной директории эталонные файлы и удалить к ним доступ (chmod a-rwx)
# Прописать для пользователя user1 возможность вызва вспомогательного скрипта в любом файле /etc/sudoers.d/* (можно сделать файл с именем user1-to-user2)
# Прописать для пользователя user2 возможность вызова sudoedit для файлов inFileName и outFileName (лучше указывать точные пути, не используя *)

# Применение скрипта без параметра nopwd
# Вставить флешку с ключевым файлом (или смонтировать под другим пользователем том veracrypt)
# Запустить вспомогательный скрипт через sudo
# Получить имена файлов (всегда одинаковые), в которых хранятся одноразовые пароли
# Запомнить, из-под какого терминала происходит запрос (скрипт пишет это)
# Перейти под пользователя user2
# Выполнить sudoedit для файла out и скопировать пароль в буфер обмена. Проверить, что пароль для нужного терминала
# Выполнить sudoedit для файла in и скопировать пароль из буфера обмена в этот файл. Сохранить и выйти
# Выйти из-под пользователя user2
# Войти под пользователя user1
# В терминале уже должен быть получен нужный скрипт

# Настройка директории keys, если ключ не находится на подключаемом носителе
# Пароль запомнить в менеджере паролей
# Создать директорию keys
# Директория имеет права на чтение и запись - любые, какие удобно
# Установить на эту директорию facl-права по умолчанию
# setfacl -dm u::wX keys
# setfacl -dm g::wX keys
# Они не дают читать из файлов, которые будут созданы в этой директории
# Создать в директории keys файл для пробы. Сделать ll. На файле должны быть права --w--w----
# После этого, если нужно, в текстовом редакторе нужно вставить пароль в новый файл, а затем сохранить этот файл в директории keys
# Необходимо также убедиться, что текстовый редактор не создаёт копий файла где бы то ни было


lecturesDir='/A/notes/Мусор/sudo_lectures/'
dirName='/inRam/consoleuser/'
mkdir -p $dirName
if [[ $? -eq 0 ]]
then
    chmod a-rwx $dirName
fi


user=$3
if [[ -z $3 ]]
then
    user='root'
fi

fromUser=$4
if [[ -z $4 ]]
then
    fromUser='ERROR'
fi

if [[ -z $1 || -z $2 || -z $4 ]]
then
    echo 'bash consoleuser.sh etalon_file key_file toUserName fromUserName'
    echo 'bash consoleuser.sh etalon_file key_file toUserName fromUserName pwd'
    echo 'bash consoleuser.sh etalon_file key_file toUserName fromUserName nopwd'
    exit
fi

 inFileName="$dirName/$fromUser.$user.in"
outFileName="$dirName/$fromUser.$user.out"

 inFileName=`realpath $inFileName`
outFileName=`realpath $outFileName`


lockDir=`realpath "$dirName/consoleuser.lock"`


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
if [[ $5 != 'nopwd' ]]
then


touch "$inFileName"
touch "$outFileName"

chmod a-rwx "$inFileName"
chmod a-rwx "$outFileName"


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
