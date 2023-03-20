xhost SI:localuser:mega

su mega -c '/home/main/bin/mega-2.sh &'

disown -a

exit
