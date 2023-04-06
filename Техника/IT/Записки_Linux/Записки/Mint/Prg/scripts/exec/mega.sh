xhost SI:localuser:mega

bash /home/main/bin/ping.sh

su mega -c '/home/main/bin/mega-2.sh &'

disown -a

exit
