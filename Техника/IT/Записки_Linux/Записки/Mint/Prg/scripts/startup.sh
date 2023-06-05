# doMessage 30 30 'deluge torrent'
function doMessage()
{
    disown -a
    sleep $1

    xmessage $3 &

    disown -a
    sleep $2
}

echo -e 'startup.sh started' &> /inRam/startup.log
date &>> /inRam/startup.log


# echo 'often.kdbx' &>> /inRam/startup.log

# keepass2 '/media/veracrypt8/Пароли/often.kdbx' -keyfile:'/media/veracrypt1/Пароли/often.key' &
# keepass2 '/media/veracrypt8/Пароли/often.kdbx' -keyfile:'/inRam/--/often.key' &
# keepass2 '/media/veracrypt8/Пароли/users.kdbx' -keyfile:'/media/veracrypt1/Пароли/users.keyx'

echo -e 'executing readers.sh'
# xfce4-terminal --tab -x bash -i ./readers.sh
bash -i ./readers.sh

disown -a
/G/disk-wait 1


echo -e 'executing notepad.sh'
# xfce4-terminal --tab -x bash -i ./notepad.sh
bash -i ./notepad.sh

disown -a
/G/disk-wait 1


echo -e 'quiterss' &>> /inRam/startup.log
echo -e 'quiterss'
date &>> /inRam/startup.log
quiterss &  &> /dev/null

disown -a
/G/disk-wait 3



# ----------------------------------------------------------------

wmctrl -s 0

echo -e 'opera' &>> /inRam/startup.log
echo -e 'opera'
date &>> /inRam/startup.log

opera %U --proxy-server="127.0.0.1:8118" & &> /dev/null

/G/disk-wait 1

disown -a
/G/disk-wait 5
/G/disk-wait 5
/G/disk-wait 5

bash ./notepad-correction.sh

# doMessage 1 1 'deluge torrent'

wmctrl -s 0
doMessage 1 1 'Windows created'

echo -e 'startup.sh ended'  &>> /inRam/startup.log
date &>> /inRam/startup.log
