cd ~

# cd /home/main/users/tor-browser

nice -n 18 /usr/bin/chromium --proxy-server="http=127.0.0.1:9001;https=127.0.0.1:9001"

disown -a

