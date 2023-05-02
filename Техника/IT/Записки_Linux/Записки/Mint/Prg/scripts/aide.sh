nice -n 19 aide --update -c /etc/aide.conf &

sleep 1

ionice -c 3 -p `pidof aide`

wait

AIDE_DIR=/A/service/aide/

if [[ ! -f $AIDE_DIR/out.db ]]
then
	echo "ERROR from $0"
	exit 1;
fi

rm $AIDE_DIR/in.db
mv $AIDE_DIR/out.db $AIDE_DIR/in.db

sudo /Arcs/Repos/smalls/aide-clamav/aide-clamav /Arcs/Repos/smalls/aide-clamav/aide-clamav.conf &> /inRam/aide-clamav.log

