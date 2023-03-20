/usr/lib/notepadqq/notepadqq-bin --new-window '/home/vinny/_/lit-dark2021/2021/План/Задание' '/home/vinny/_/lit-dark2021/2021/Текст/Глава 03' '/home/vinny/_/notes/Творчество/Как делать сюжеты/1.md' &  &> /inRam/startup-nqq_nw.log


pt=`pwd`


cd /home/vinny/_/lit-dark2021/expense/

/usr/bin/octave --gui &

cd $pt

disown -a
