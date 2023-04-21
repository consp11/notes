cd ~

nice -n 18 quiterss

sleep 1

ionice -c 3 -p `pidof quiterss`

disown -a

