xhost SI:localuser:deluge

bash /home/main/bin/ping.sh

su deluge -c '/home/main/bin/deluge-2.sh &'

disown -a

exit
