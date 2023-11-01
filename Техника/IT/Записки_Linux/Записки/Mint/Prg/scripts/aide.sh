sudo -v

function waitPing()
{
    i=$1
    # Ожидаем появления интернета
    ping -s 16 -c 1 77.88.8.88 &>> /dev/null
    while [[ $? -ne 0 && $i -gt 0 ]]
    do
      sleep 5
      i=$(($i-1))
      ping -s 16 -c 1 77.88.8.88 &>> /dev/null
    done

    ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'
}

nice -n 19 aide --update -c /etc/aide.conf &

sleep 0.3

ionice -c 3 -p `pidof aide`
chrt -b -p 0 `pidof aide`


# Ждём интернета 30 минут
waitPing 360

sudo -u clamav nice -n 19 freshclam --no-dns --stdout &

sleep 0.3

ionice -c 3 -p `pidof freshclam`
chrt -i -p 0 `pidof freshclam`




wait

AIDE_DIR=/A/service/aide/

if [[ ! -f $AIDE_DIR/out.db ]]
then
	echo "ERROR from $0"
	exit 1;
fi

rm $AIDE_DIR/in.db
mv $AIDE_DIR/out.db $AIDE_DIR/in.db



pwd=`pwd`
cd /inRam

/Arcs/Repos/smalls/aide-clamav/aide-clamav /Arcs/Repos/smalls/aide-clamav/aide-clamav.conf &
bash -i /Arcs/Repos/smalls/dotnet-temp-utils/setBinExecute/exec-aide.sh &


echo pidof aide-clamav
pidof aide-clamav

ionice -c 3 -p `pidof aide-clamav`
chrt -b -p 0 `pidof aide-clamav`

echo pidof setBinExecute
pidof setBinExecute

ionice -c 3 -p `pidof setBinExecute`
chrt -b -p 0 `pidof setBinExecute`


cd $pwd


echo
echo ----------------------------------------------------------------
sudo ausearch -i -sv no
echo ----------------------------------------------------------------
#sudo aa-logprof
sudo cat /var/log/audit/audit.log | egrep apparmor=\"D
echo ----------------------------------------------------------------
echo ----------------------------------------------------------------
echo


wait

echo
echo ----------------------------------------------------------------
echo end
echo ----------------------------------------------------------------
echo
