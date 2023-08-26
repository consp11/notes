# --sync - ждём, пока не появится хотя бы одно такое окно
xdotool search --sync --onlyvisible --limit 1 --name --class --classname "$1" >> /dev/null

#wcl=0
#while [ $wcl -eq 0 ]
#do
#  sleep 5
#  wcl=$((  `xdotool search --onlyvisible --limit 1 --name "$1" | wc -l`  ))
#
#done
