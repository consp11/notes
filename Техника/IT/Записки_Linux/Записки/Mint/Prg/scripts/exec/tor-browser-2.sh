#cd ~

cd /home/main/users/tor-browser

# cd bin/tor-browser/Browser
cd bin/tor-browser/
# shopt -s expand_aliases

# nice -n 17 /usr/bin/env ./start-tor-browser.desktop

# PATH=$PATH:/home/main/users/tor-browser/bin/tor-browser

# bash -i
# /home/main/users/tor-browser/bin/tor-browser/Browser

# ./firefox --class "Tor Browser" --name "Tor Browser"
nice -n 17 /home/main/users/tor-browser/bin/tor-browser/start-tor-browser.desktop
# nice -n 17 /home/main/users/tor-browser/bin/tor-browser/start-tor-browser.desktop

disown -a
