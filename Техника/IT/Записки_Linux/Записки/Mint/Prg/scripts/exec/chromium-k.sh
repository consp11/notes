xhost SI:localuser:chromium-k

su chromium-k -c '/home/main/bin/chromium-2.sh &'

disown -a

exit
