# Ожидаем появления интернета
ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'
while [ $? -ne 0 ]
do
  sleep 5
  ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'
done


sudo -u clamav freshclam >& /inRam/clamav.log

# sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=yes --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/bin /usr/sbin /usr/**/bin /usr/**/sbin /usr/lib* /usr/local/lib* /opt >>& /inRam/clamav.log

# sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/bin /usr/sbin /usr/**/bin /usr/**/sbin /opt &>> /inRam/clamav.log

sudo nice -n 19 clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=12M --max-scansize=12M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=12M --bytecode-timeout=600000 --scan-archive=no --scan-xmldocs=no --scan-hwp3=no --scan-html=no --scan-swf=no --scan-pdf=no --scan-pe=no --phishing-scan-urls=no --scan-mail=no --phishing-sigs=no --scan-elf=yes /usr/sbin /usr/bin /usr/**/bin /usr/**/sbin /opt /boot &>> /inRam/clamav.log &

# /usr/sbin /usr/bin /usr/**/bin /usr/**/sbin /opt /boot

# /usr/sbin /usr/**/bin /usr/**/sbin &>> /inRam/clamav.log

sleep 1
ionice -c 3 -p `pidof clamscan`

wait
