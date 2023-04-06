xhost SI:localuser:chromium-k

bash /home/main/bin/ping.sh

su chromium-k -c '/home/main/bin/chromium-2.sh &'

disown -a

exit
