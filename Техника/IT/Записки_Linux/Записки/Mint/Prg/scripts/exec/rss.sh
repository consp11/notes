xhost SI:localuser:quite-rss

su quite-rss -c '/home/main/bin/rss-2.sh &'

disown -a

exit
