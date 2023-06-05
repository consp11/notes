xhost SI:localuser:deluge

bash /home/main/bin/ping.sh

echo 'deluge'

su deluge -c 'bash -i /home/main/bin/deluge-2.sh &'

disown -a

exit
