
# Запуск:
# /media/veracrypt8/cp-git.sh $GIT_LOG $GIT_LOG_H &> $GIT_LOG &

# Открываем менеджер паролей, чтобы дальше было легко закоммитить изменения
# keepass2 '/media/veracrypt1/Старые пароли/often.kdbx' -keyfile:'/media/veracrypt1/Старые пароли/often' &

# Это выдаст приглашение на ввод пароля, вместо автоматического открытия БД
# keepass2 '/media/veracrypt1/Старые пароли/often.kdbx' -preselect:'/media/veracrypt1/Старые пароли/often' &

whoami | fgrep -vx a1

# Ожидаем появления интернета
ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'
while [ $? -ne 0 ]
do
  sleep 5
  ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'
done


gold=`pwd`
cd /Arcs/Repos

function commit()
{
	list=$*
	# echo ${list[@]}

	for dir in ${list[@]}
	do
		local old=`pwd`
		# echo -e "\nwork with '$dir' (old='$old')"

		# Это излишняя проверка на то, что мы не работаем с файлами
		if [ ! -d $dir ]
		then
			echo '\033[41m!!!!!!!!!!!!!!!! ПРОВЕРКА СРАБОТАЛА (не должна была) !!!!!!!!!!!!!!!!\033[0;0m'
			echo "$dir"
			echo
			continue;
		fi

		cd $dir

		# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html
		if [ $? -ne 0 ]
		then
			echo "\033[41mcd '$dir' unsuccessfull (old='$old')\033[0;0m"
			cd $old
			break;
		fi


		# Если .git в наличии, вызываем git
		# Иначе мы ищем каталоги в поддиректориях, т.к. это могут быть каталоги репозиториев
		if [ -d ".git" ]
		then
			echo
			echo `date`
			# Цвета https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
			echo -e "\033[97;40m\nwork with '$dir' (old='$old')\033[0;0m"

			# Это надо только один раз запустить для каждого пользователя. Далее закомментировать
			# git config --global --add safe.directory `pwd`

			git add .
			git commit -m "automatic commit"
			git push -v
			# echo "commit " `pwd`
		else
			# Перенаправление ошибок делаем в связи с тем, что некоторые директории не имеют .git (не являются репозиториями)
			# и, соответственно, рекурсивно проходят до нижней директории, после этого `ls -1d */` выдаёт ошибку
			repos=`ls -1d */ 2> /dev/null`
			# echo 'recursive commit'
			# echo ${repos[@]}
			commit ${repos[@]}
		fi

		# echo "return to $old"
		cd $old
		echo
	done
}

especials=(  '/Arcs/A/notes/'  '/media/veracrypt3/Литература/Стеллар-Фанфик/lit-dark2021/'  '/home/g2/Games/DefilerWings'  )
commit ${especials[@]}

# Для получения папок можно использовать следующие команды:
# find -maxdepth 1 -type d # Это выведет и "."
# ls -1d */ # Это то, что нужно. Обратим внимание на завершающий "/"
repos=`ls -1d */`
commit ${repos[@]}


cd $gold

echo 'cp-git.sh has ended'

if [ -n $1 ]
then
	echo 'posted:'

	egrep -i ^POST.* $1 &> $2
	egrep -i ^fatal:.* $1 &>> $2
	cat $2

	xfce4-terminal --hold -x cat $1
fi
