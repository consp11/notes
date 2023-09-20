ecryptfs-mount-private

sudo -v

# --fs-options=rw,relatime

sudo /usr/bin/veracrypt -t -v --slot=1 --pim=0 --protect-hidden=no --mount-options=ts --fs-options=ro --keyfiles="/Arcs/keys-main.key" "/Arcs/Disks/ya/Crypto/keys-main" "/media/veracrypt1"

# nomount
# noaide noav av
/media/veracrypt1/mount.sh $*
