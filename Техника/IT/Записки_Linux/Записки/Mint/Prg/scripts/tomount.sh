#!/usr/bin/bash

#!/usr/bin/xfce4-terminal -x bash -i
#!xfce4-terminal -x bash -i

# /usr/bin/bash
# xfce4-terminal -x bash -i %1
# /media/veracrypt1/tomount.sh

# Цвета можно получить командой xfce4-terminal --color-table

# Убрал -v -p "" --pim=0
# -v выводит окно с сообщением (если нет флага -t) о монтировании
# -p "" - пароль
# --pim=0 - pim по умолчанию
# --protect-hidden=no
# всё это препятствует выводу окна монтирования (монтирование будет автоматом идти, без запроса параметров)

# --filesystem=none - не монтирует диск

# & - параллельное выполнение

# Это нужно, чтобы сразу ввести пароль, а не делать это много раз
sudo echo "Начинаем расшифровку и монтирование"

# Если произошла ошибка (например, три раза неверно введён пароль)
if [ $? -ne 0 ]
then
    echo "Ошибка после echo"
	exit;
fi

# Убираем демона Thunar, т.к. он иногда виснет, похоже
Thunar -q

# Закрываем окно VeraCrypt. -F - флаг для того, чтобы не закрывать другие окна, в которых случайно тоже оказалось "veracrypt". Например, может быть закрыт текстовый редактор, в котором редактируется файл с путём, содержащим veracrypt (/media-veracrypt1)
wmctrl -Fc "VeraCrypt"


# ----------------------------------------------------------------

# Устанавливаем 1,6 ГГц как максимальную частоту
sudo bash ./powersafe.sh

# Отключаем историю внутри файла
history -c
export HISTFILE=/dev/null
#export HISTSIZE=50
#export HISTFILESIZE=0
# vinny: -u - отключает опцию добавления в лог-файл; man bash.1
# shopt -s histappend
shopt -u histappend
# ignorespace ignoredups ignoreboth
export HISTCONTROL=ignoreboth
export HISTIGNORE=clear:history


# Устанавливаем возможность открытия окон пользователем br1 на рабочем столе vinny
# xhost +si:localuser:br1
# xhost +si:localuser:dev


# Вызываем скрипт копирования всего подряд для резервного копирования
sudo bash ./cp-a.sh
./cp.sh &> /inRam/cp.log

doAIDE=1
for a in $*
do
	if [ $a == "noaide" ]
	then
		doAIDE=0
	fi
done

# Отключил ClamAV по-умолчанию, т.к. aide.sh его всё равно запустит
doClamAV=0
for a in $*
do
	if [ $a == "noav" ]
	then
		doClamAV=0
	fi

	if [ $a == "av" ]
	then
		doClamAV=1
	fi
done


# Запускаем проверку
# sudo aide --check -c /etc/aide.conf &
if [ $doAIDE -eq 1 ]
then
	sudo bash ./aide.sh &
fi


# ----------------------------------------------------------------

PRE=`sudo veracrypt -t -l | wc -l`
CNT=PRE


# ----------------------------------------------------------------
# Монтируем музыку
mkdir -p /inRam/Music
/usr/bin/veracrypt -t -v --slot=64 -p "" --pim=1 --protect-hidden=no --mount-options=ts,ro --fs-options=ro,relatime,noexec --keyfiles="/media/veracrypt1/books/Music/books-m1-gXLm3HWPYpXR-1.key","/media/veracrypt1/books/Music/books-m1-gXLm3HWPYpXR-2.key" "/Arcs/Big/books/books-m1-gXLm3HWPYpXR" "/inRam/Music"
CNT=$(($CNT+1))


# ----------------------------------------------------------------
# Монтируем основных пользователей
# sudo mkdir -p /home/main; sudo chmod a-rw+t /home/main; sudo chattr +i /home/main
/usr/bin/veracrypt -t -v --slot=33 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime --keyfiles="/media/veracrypt1/Диски/users.key" "/Arcs/Big/users" "/home/main"
CNT=$(($CNT+1))


# ----------------------------------------------------------------
# Монтируем временные документы
/usr/bin/veracrypt -t -v --slot=10 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/tmp/tmp-20220720.key" "/Arcs/Big/tmp-docs" "/home/main/users/inet/Docs"
CNT=$(($CNT+1))


# ----------------------------------------------------------------
# Монтируем видео 64 Гб
# mkdir /big/video-64
/usr/bin/veracrypt -t -v --slot=63 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/films/killjoys.key" "/Arcs/Big/RyLP5O3Qh8E3O" "/big/video-64"
CNT=$(($CNT+1))


# ----------------------------------------------------------------
# Монтируем пользователя g
/usr/bin/veracrypt -t -v --slot=11 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime --keyfiles="/media/veracrypt1/vm/g-2022-0217.key" "/Arcs/Big/g" "/home/g"
CNT=$(($CNT+1))


# ----------------------------------------------------------------
# Монтируем пользователя g2 и других, а также папки
/usr/bin/veracrypt -t -v --slot=12 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime --keyfiles="/media/veracrypt1/vm/g2-2022-08-24.key" "/Arcs/Big/g2" "/home/g2/"
CNT=$(($CNT+1))


# ----------------------------------------------------------------
# Монтируем литературу
# /usr/bin/veracrypt -t -v --slot=3 -p "" --pim=0 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/Literature.key" "/Arcs/Big/Crypto/disks/Literature" "/media/veracrypt3" &
/usr/bin/veracrypt -t -v --slot=3 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/Диски/Literature-2.key" "/Arcs/Big/Crypto/disks/Literature-2" "/media/veracrypt3"
CNT=$(($CNT+1))

sudo chown inet:arcs-read /media/veracrypt3
sudo chmod o-rwx /media/veracrypt3

# ----------------------------------------------------------------
# Монтируем планы
# /usr/bin/veracrypt -t -v --slot=2 -p "" --pim=0 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/Plans.key" "/Arcs/Big/Crypto/disks/Plans" "/media/veracrypt2" &
/usr/bin/veracrypt -t -v --slot=2 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/Диски/Plans-2.key" "/Arcs/Big/Crypto/disks/Plans-2" "/media/veracrypt2"
CNT=$(($CNT+1))

sudo chown inet:arcs-read /media/veracrypt2
sudo chmod o-rwx /media/veracrypt2

# ----------------------------------------------------------------
# Монтируем диск для виртуальных машин
/usr/bin/veracrypt -t -v --slot=62 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime,noexec --keyfiles="/media/veracrypt1/vm/vm-2022-09-29.key" "/Arcs/Big/vm-2022-09-29" "/media/veracrypt62"
CNT=$(($CNT+1))

sudo chown inet:arcs-read /media/veracrypt62
sudo chmod o-rwx /media/veracrypt62


# Автоматический вызов коммитов git, если где-то были забыты коммиты
GIT_LOG=/inRam/cp-git.log
GIT_LOG_H=/inRam/cp-git-h.log
/media/veracrypt8/cp-git.sh $GIT_LOG $GIT_LOG_H &> $GIT_LOG &
# disown

# ----------------------------------------------------------------
# Выполняем стартап-скрипты
# bash не хочет просто так выполняться
# А сам скрипт закрывает все программы после того, как сам закрывается
# Да и ввод не очень хочется делать
# xfce4-terminal --tab -x bash -i startup.sh &


# echo '!!!!!!!!!!!!!!!!!!!!!!!!'
# xfce4-terminal --tab -x bash -i ./startup.sh &

cp -fvu /home/main/bin/*.sh    /home/a1/_/Linux_Записки_Prg/scripts/exec

if [ $doClamAV -eq 1 ]
then
	sudo bash -i ./clamav-2.sh &
fi


echo


JC=`jobs | wc -l`
while [ $JC -gt 0 ]
do
	CD=`sudo veracrypt -t -l | wc -l`
    JC=`jobs | wc -l`
	# Почему-то иногда эхо от veracrypt накладывается на дальше выводимые эха. Делаем отступы
	# Поэтому, стараемся сократить время перевода курсора назад
	tput sc
    echo -e "Подключёных дисков: $CD / $CNT\nОжидаем работ: $JC"
	sudo echo -n
	tput rc

	wait -n
	JC=`jobs | wc -l`
done

# На всякий случай ждём завершения всех потоков. Хотя они и так уже все должны были завершиться
wait

disown -a

i=22
while [ $i -gt 0 ]
do
	CD=`sudo veracrypt -t -l | wc -l`

	# Сохраняем позицию курсора. После вывода возвращаем курсор назад
    tput sc

	# Если всё успешно
	if [ $CD -eq $CNT ]
	then
		echo -e "\033[32mПодключёных дисков: $CD / $CNT. Завершение через $i секунд.   \033[0m"
		# Дополнительно сокращаем время ожидания конца ввода
		i=$(($i-2))
	else
		echo -e "\033[41mПодключёных дисков: $CD / $CNT. Завершение через $i секунд.   \033[0m"
	fi
	# При длительном ожидании авторизованное sudo не должно вылетать: иначе снова будет запрос пароля
	sudo echo -n
	tput rc

	i=$(($i-1))
	sleep 1
done

echo

sudo chmod g+r /A/service/aide/report.log
xfce4-terminal --hold -x cat /A/service/aide/report.log

if [ $doClamAV -eq 1 ]
then
	sudo chmod g+r /inRam/clamav.log
	xfce4-terminal --hold -x cat /inRam/clamav.log
fi

sudo chmod g+r /inRam/aide-clamav.log
xfce4-terminal --hold -x cat /inRam/aide-clamav.log

disown -a
