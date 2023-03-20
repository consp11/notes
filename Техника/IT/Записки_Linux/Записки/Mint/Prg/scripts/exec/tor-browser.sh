xhost SI:localuser:tor-browser

su tor-browser -c '/home/main/bin/tor-browser-2.sh &'
disown -a

exit
