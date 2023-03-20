wmctrl -s 7

echo -e 'xreader' &>> /inRam/startup.log
date &>> /inRam/startup.log



xreader '/home/vinny/Docs/Тетлок Ф., Гарднер Д. - Думай медленно - предсказывай точно/Тетлок Ф., Гарднер Д. - Думай медленно - предсказывай точно.pdf' '/home/vinny/Docs/Математика/hott-ebook-1353-g16a4bfa.pdf' &  &> /dev/null

disk-wait 1
disown -a

# ----------------------------------------------------------------

wmctrl -s 7

echo -e 'ebook-viewer' &>> /inRam/startup.log
date &>> /inRam/startup.log

# /usr/bin/ebook-viewer '/home/vinny/Docs/Влад Лей/Хруст/7. kolonisty_khozyaeva_khrusta.fb2' &  &> /dev/null

# /usr/lib/notepadqq/notepadqq-bin --new-window '/home/vinny/Видео/испр-колонисты5'  &  &> /dev/null


disk-wait 1
disown -a



wmctrl -s 7

./_sh/dark-read.sh

thunar '/big/video-64/Masters of Science Fiction - LostFilm.TV/' &
# thunar '/home/vinny/Docs/Сергей Лукьяненко-Собрание сочинений/' &

disk-wait 1
disown -a


wmctrl -s 0

# thunar '/home/vinny/Docs/Иные/' &
# thunar '/big/video-64/' &

wmctrl -s 0

disk-wait 1
disown -a
