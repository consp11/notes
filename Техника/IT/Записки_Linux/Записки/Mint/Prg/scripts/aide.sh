sudo -v

nice -n 19 aide --update -c /etc/aide.conf &
sudo -u clamav nice -n 19 freshclam --no-dns --stdout &

sleep 1

ionice -c 3 -p `pidof aide`
ionice -c 3 -p `pidof freshclam`

chrt -b -p 0 `pidof aide`
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


# Ожидаем появления интернета
#ping -c 1 77.88.8.88 -s 16
#while [ $? -ne 0 ]
#do
#  sleep 5
#  ping -c 1 77.88.8.88 -s 16 &> /dev/null
#done


sudo -u clamav freshclam --no-dns --stdout


/Arcs/Repos/smalls/aide-clamav/aide-clamav /Arcs/Repos/smalls/aide-clamav/aide-clamav.conf &
bash -i /Arcs/Repos/smalls/dotnet-temp-utils/setBinExecute/exec-aide.sh &

sleep 1

ionice -c 3 -p `pidof aide-clamav`
chrt -b -p 0 `pidof aide-clamav`

ionice -c 3 -p `pidof setBinExecute`
chrt -b -p 0 `pidof setBinExecute`

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
