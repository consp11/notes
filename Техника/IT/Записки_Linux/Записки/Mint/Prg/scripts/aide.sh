aide --update -c /etc/aide.conf

AIDE_DIR=/A/service/aide/

if [[ ! -f $AIDE_DIR/out.db ]]
then
	echo "ERROR from $0"
	exit 1;
fi

rm $AIDE_DIR/in.db
mv $AIDE_DIR/out.db $AIDE_DIR/in.db
