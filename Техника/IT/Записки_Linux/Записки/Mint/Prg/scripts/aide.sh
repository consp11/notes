nice -n 19 aide --update -c /etc/aide.conf &
sudo -u clamav nice -n 19 freshclam >& /inRam/clamav.log &

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
ping -c 1 77.88.8.88
while [ $? -ne 0 ]
do
  sleep 5
  ping -c 1 77.88.8.88 >& /dev/null
done


sudo -u clamav freshclam >& /inRam/clamav.log


sudo /Arcs/Repos/smalls/aide-clamav/aide-clamav /Arcs/Repos/smalls/aide-clamav/aide-clamav.conf &> /inRam/aide-clamav.log

sleep 0.1

ionice -c 3 -p `pidof aide-clamav`
chrt -b -p 0 `pidof aide-clamav`
