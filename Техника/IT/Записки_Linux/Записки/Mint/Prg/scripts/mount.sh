sudo echo "---------------- Begin ----------------"

sudo chown a1:passwords /media/veracrypt1
sudo chmod o-rwx /media/veracrypt1


/usr/bin/veracrypt -t -v --slot=8 -p "" --pim=1 --protect-hidden=no --mount-options=ts --fs-options=rw,relatime --keyfiles="/media/veracrypt1/Диски/keys-var.key" "/Arcs/Big/Crypto/keys-var" "/media/veracrypt8"

sudo chown a1:crypto /media/veracrypt8
sudo chmod o-rwx /media/veracrypt8

ls -AlFb /media/ | egrep -v '(crypto|arcs-read)'


sudo echo "------------ Start /media/veracrypt8/tomount.sh --------------------"

cd /media/veracrypt8/
/media/veracrypt8/tomount.sh

sudo echo "---------------- Ended ----------------"

sleep 3
