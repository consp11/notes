cd ~

# cd /home/main/users/tor-browser

cd bin/tor-browser/

nice -n 17 ./start-tor-browser.desktop

disown -a
