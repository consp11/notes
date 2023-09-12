xhost SI:localuser:ch-diet

# bash /home/main/bin/ping.sh

echo 'ch-diet-proxy'

# cd /home/main/users/tor-browser/bin/tor-browser/Browser
cd /home/main/users/ch-diet/

# su tor-browser-proxy -c '/home/main/bin/tor-browser-proxy.sh'
su ch-diet -c '/home/main/bin/chromium-2.sh &'
disown -a

exit
