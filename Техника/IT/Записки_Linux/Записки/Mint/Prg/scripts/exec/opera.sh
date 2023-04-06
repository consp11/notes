xhost SI:localuser:opera

bash /home/main/bin/ping.sh

su opera -c '/home/main/bin/opera-2.sh &'

disown -a

exit
