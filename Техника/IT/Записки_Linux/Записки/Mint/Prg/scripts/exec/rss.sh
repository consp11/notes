xhost SI:localuser:quite-rss

bash /home/main/bin/ping.sh

echo 'quite-rss'

su quite-rss -c '/home/main/bin/rss-2.sh &'

disown -a

exit
