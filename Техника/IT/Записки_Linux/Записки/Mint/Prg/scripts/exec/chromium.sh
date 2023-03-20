xhost SI:localuser:chromium

su chromium -c '/home/main/bin/chromium-2.sh &'

disown -a

exit
