# xhost SI:localuser:a1

wmctrl -s 0

echo 'notepadqq-bin' &>> /inRam/startup.log
date &>> /inRam/startup.log

# nice -n 11 /usr/lib/notepadqq/notepadqq-bin &  &> /inRam/startup-nqq-s.log

# nice -n 19 disk-wait 1

# --new-window
#nice -n 11 /usr/lib/notepadqq/notepadqq-bin --new-window \
#'/home/main/users/inet/_/keys-var/notepad.sh' \
#'/home/main/users/inet/_/plans/Планы/Дела/--0' \
#'/home/main/users/inet/_/plans/Планы/+' \
#"/home/main/users/inet/_/plans/Планы/Дела/Частые" \
#'/Arcs/Repos/consp11.github.io/free/05/Конспекты/Проектирование/Заметки' \
#&  &> /inRam/startup-nqq-pl.log

#nice -n 11 /usr/lib/notepadqq/notepadqq-bin --new-window \
#'/Arcs/Repos/consp11.github.io/free/05/Конспекты/2023/05 Май-14-Маск' \
#'/home/main/users/inet/_/lit/Корректура/Живой доспех' \
#&  &> /inRam/startup-nqq-pl.log


xreader /home/main/users/inet/Docs/Математика/2024/Ещё/Группы-симметрии-Флари.djvu


# /usr/bin/ebook-viewer '/home/main/users/inet/Docs/Сергей Лукьяненко-Собрание сочинений/Соглашение/3. Прыжок.fb2' &  &> /dev/null

# Thunar '/home/main/users/inet/Docs/Звездная Елена/FB2/Долина драконов/'
#Thunar \
# '/home/main/users/inet/Docs/Сапковский+/Анджей Сапковский - Ведьмак (сборник) (Сага о ведьмаке) - 2014/' \
#'/home/main/users/inet/Docs/Тетлок Ф., Гарднер Д. - Думай медленно - предсказывай точно/' \
#&

#Thunar \
#'/media/veracrypt8/_sh/' \
#&

# Thunar '/Arcs/tmp/ВидеоПроекты/2023-12-заметки/' &


#nice -n 19 disk-wait 1
#sleep 4
#wmctrl -s 1
#/home/main/users/inet/_/keys-var/_sh/dark-read.sh
#wmctrl -s 0


# '/big/video-64/Waco/' \
# '/home/main/users/deluge/Загрузки/' \

# ./_sh/kgk.sh


# nice -n 19 disk-wait 1

# wmctrl -s 0

# bash -i /home/vinny/_/keys-var/_sh/tree-lang.sh
# bash -i /home/vinny/_/keys-var/_sh/vinkekfish-csharp.sh

# xmessage 'Persepolis Ubuntu'

disown -a
# nice -n 19 disk-wait 1

echo 'notepad.sh ended' &>> /inRam/startup.log
date &>> /inRam/startup.log
