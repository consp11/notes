cd ~

# cd /home/main/users/tor-browser

# nice -n 18 opera
nice -n 19 deluge

sleep 1

ionice -c 3 -p `pidof deluge-gtk`

disown -a

