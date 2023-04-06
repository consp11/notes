xhost SI:localuser:chromium

bash /home/main/bin/ping.sh

su chromium -c '/home/main/bin/chromium-2.sh &'

disown -a

exit
