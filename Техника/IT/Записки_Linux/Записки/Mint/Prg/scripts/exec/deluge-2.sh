cd ~

# cd /home/main/users/tor-browser

# nice -n 18 opera
nice -n 19 deluge

sleep 1

sudo oinice -c 3  `pidof deluge-gtk`;

disown -a

