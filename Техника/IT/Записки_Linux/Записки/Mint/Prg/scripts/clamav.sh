
# sudo clamscan -iozr --follow-dir-symlinks=0 --follow-file-symlinks=0 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=yes --bytecode-timeout=600000


sudo echo 'Start clamav executing'
date

sudo -u vinny /home/vinny/_/keys/clamav-v.sh

sudo -u clamav freshclam


echo '/home' > /inRam/avh.txt
date +'%A %d %B %Y  %H:%M:%S GMT%:::z' >> /inRam/avh.txt

sudo clamscan -iozr --follow-dir-symlinks=0 --follow-file-symlinks=0 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=yes --bytecode-timeout=600000 /home &>> /inRam/avh.txt &


echo '/usr' > /inRam/avu.txt
date +'%A %d %B %Y  %H:%M:%S GMT%:::z' >> /inRam/avu.txt

sudo clamscan -iozr --follow-dir-symlinks=0 --follow-file-symlinks=0 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=yes --bytecode-timeout=600000 /usr/ &>> /inRam/avu.txt &


# /G/

sudo echo 'Wait for clamav'
date
wait
