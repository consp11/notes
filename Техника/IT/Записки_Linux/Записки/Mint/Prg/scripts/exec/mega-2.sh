cd ~

nice -n 19 megasync &

sleep 1

ionice -c 3 -p `pidof megasync`

disown -a

