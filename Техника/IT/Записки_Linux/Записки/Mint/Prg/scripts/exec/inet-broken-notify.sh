# Ожидаем появления интернета
# bash -i /home/main/bin/inet-broken-notify.sh

date
dateFormat='+%H:%M:%S'

ping -s 16 -c 2 77.88.8.88 -i 0.5 -O | egrep --color=never '(icmp_seq=|ping\:)'

cnt=0

while true
do
    
    cnt2=0
    last=`date +%s`
    while [[ $cnt2 -le 60 ]]
    do
        tput sc
        now=`date +%s`
        int=$(( $now-$last ))
        echo -n $int 'секунд'

        read -t 3 $T
        if [[ $? -eq 0 ]]
        then
            break
        fi
        
        cnt2=$(( $cnt2+1 ))

	    tput rc
    done
    
    if [[ $cnt -gt 8 ]]
    then
        # clear
        cnt=0
    else
        cnt=$(( $cnt-1 ))
    fi


    echo
    # date $dateFormat
    #pngstr=`ping -s 16 -c 2 77.88.8.88 -i 1.83 -O`
    #pngres=$?
    # echo "$pngstr" | egrep --color=never '(icmp_seq=|ping\:)'
    ping -s 16 -c 2 77.88.8.88 -i 1.83 -O | egrep --color=never '(icmp_seq=|ping\:)'

done

