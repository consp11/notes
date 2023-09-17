xhost SI:localuser:tor-browser

bash /home/main/bin/ping.sh

echo 'tor-browser'

# cd /home/main/users/tor-browser/bin/tor-browser/Browser
cd /home/main/users/tor-browser/bin/tor-browser/

# su tor-browser-proxy -c '/home/main/bin/tor-browser-proxy.sh'
su tor-browser -c '/home/main/bin/tor-browser-2.sh'
disown -a

exit
