# Ожидаем появления интернета
ping -c 1 77.88.8.88 -s 16
while [ $? -ne 0 ]
do
  sleep 5
  ping -c 1 77.88.8.88 -s 16 >& /dev/null
done


sudo -u clamav freshclam >& /inRam/clamav.log

# sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=yes --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/bin /usr/sbin /usr/**/bin /usr/**/sbin /usr/lib* /usr/local/lib* /opt >>& /inRam/clamav.log

# sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/bin /usr/sbin /usr/**/bin /usr/**/sbin /opt &>> /inRam/clamav.log

# sudo systemd-run --scope -p CPUQuota=10%
sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=512M --max-scansize=512M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=no --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=512M --bytecode-timeout=600000 /usr &> /inRam/clamav-all-usr.log &

# sudo systemd-run --scope -p CPUQuota=10%
sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=512M --max-scansize=512M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=no --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=512M --bytecode-timeout=600000 /opt &> /inRam/clamav-all-opt.log &

# sudo systemd-run --scope -p CPUQuota=10%
sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=512M --max-scansize=512M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=no --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=512M --bytecode-timeout=600000 /home &> /inRam/clamav-all-home.log &

# sudo systemd-run --scope -p CPUQuota=10%
sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=512M --max-scansize=512M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=no --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=512M --bytecode-timeout=600000 /etc &> /inRam/clamav-all-etc.log &

# sudo systemd-run --scope -p CPUQuota=10%
sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=512M --max-scansize=512M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=no --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=512M --bytecode-timeout=600000 /var &> /inRam/clamav-all-var.log &

# /usr/sbin /usr/**/bin /usr/**/sbin &>> /inRam/clamav.log

sleep 1
sudo renice -n 19   `pidof clamscan`
sudo ionice -c 3 -p `pidof clamscan`

JC=`jobs | wc -l`
while [ $JC -gt 0 ]
do
    JC=`jobs | wc -l`
	# Почему-то иногда эхо от veracrypt накладывается на дальше выводимые эха. Делаем отступы
	# Поэтому, стараемся сократить время перевода курсора назад
	tput sc
    echo -e "Ожидаем окончания выполнения $JC" "\t\t|\t" `date`
	tput rc

	wait -n
	JC=`jobs | wc -l`
done

wait

