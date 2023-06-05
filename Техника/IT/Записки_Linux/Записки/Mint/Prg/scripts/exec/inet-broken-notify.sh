# Ожидаем появления интернета
# bash -i /home/main/bin/inet-broken-notify.sh

date
dateFormat='+%H:%M:%S'

isHaveInternet=true
ping -s 16 -c 2 77.88.8.88 -i 0.5 -O | egrep --color=never '(icmp_seq=|ping\:)'
if [ $? -ne 0 ]
then
	isHaveInternet=
fi

cnt=0

while true
do
    
    cnt2=0
    last=`date +%s`
    while [[ cnt2 -le 60 ]]
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

    if [ $? -ne 0 ]
    then
        if [ $isHaveInternet ]
        then
            dt=`date`
            pn=`ping -s 16 -c 4 77.88.8.88 -i 0.83 -O`
            if [ $? -eq 0 ]
            then
                continue
            fi

            notify-send -t 600000 "Интернет отвалился" "$dt\n\n$pn"

            echo
            echo
            date
            echo "Интернет отвалился"
            echo

            cnt=0
            read -t 60
        fi
        echo $isHaveInternet
        isHaveInternet=
    else
        if [ ! $isHaveInternet ]
        then
            dt=`date`
            pn=`ping -s 16 -c 4 77.88.8.88 -i 0.83 -O | egrep -o '(time=.*|.*no answer.*)'`
            notify-send -t 120000 "Интернет восстановился" "<i>$dt</i>"

            echo
            echo
            date
            echo "Интернет восстановился"
            echo

            cnt=0
            read -t 60
        fi

        isHaveInternet=true
    fi

done

