# xhost SI:localuser:a1

wmctrl -s 0

echo 'notepadqq-bin' &>> /inRam/startup.log
date &>> /inRam/startup.log

/usr/lib/notepadqq/notepadqq-bin &  &> /inRam/startup-nqq-s.log


disk-wait 1

# --new-window
/usr/lib/notepadqq/notepadqq-bin --new-window '/home/main/users/inet/_/keys-var/notepad.sh' '/home/main/users/inet/_/plans/Планы/Дела/--0' '/home/main/users/inet/_/plans/Планы/+' "/home/main/users/inet/_/plans/Планы/Дела/Частые" '/A/service/aide/report.log' '/home/main/users/inet/_/lit/Корректура/Прыжок.txt' '/A/service/aide/report.log' '/home/main/users/inet/_/lit/Литература/Религия/Пост/11 Немного о голодании.txt' &  &> /inRam/startup-nqq-pl.log

# /usr/bin/ebook-viewer '/home/main/users/inet/Docs/Сергей Лукьяненко-Собрание сочинений/Соглашение/3. Прыжок.fb2' &  &> /dev/null

Thunar '/home/main/users/inet/Docs/Звездная Елена/FB2/СИ/Лесная ведунья/'

# ./_sh/kgk.sh


disk-wait 1

wmctrl -s 0

# bash -i /home/vinny/_/keys-var/_sh/tree-lang.sh
# bash -i /home/vinny/_/keys-var/_sh/vinkekfish-csharp.sh


disown -a
disk-wait 1
