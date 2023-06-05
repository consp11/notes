xhost SI:localuser:chromium

bash /home/main/bin/ping.sh

echo 'chromium'

su chromium -c '/home/main/bin/chromium-2.sh &'

disown -a

exit
