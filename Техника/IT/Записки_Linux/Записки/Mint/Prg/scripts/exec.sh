# cp -fv /Arcs/Disks/Mega/MEGAsync/Записки/Mint/Prg/scripts/exec.sh /home/vr
# cp -fv /home/vr/exec.sh /Arcs/Disks/Mega/MEGAsync/Записки/Mint/Prg/scripts/

#echo 'exec.sh start'
#exit

# Добавляем команду для раскрытия алиасов во внеинтерактивной оболочке
shopt -s expand_aliases
alias sd='sudo sdel -'
# alias sd='echo'

sd /Arcs/keys-main.key &> /dev/null

sudo /usr/bin/veracrypt -t -d --force &> /dev/null

sudo /usr/bin/killall -q -u inet
sudo /usr/bin/killall -q -u a1
sudo /usr/bin/killall -q -u first
sudo /usr/bin/killall -q -u game
sudo /usr/bin/killall -q -u deluge
sudo /usr/bin/killall -q -u dev
sudo /usr/bin/killall -q -u clamav
sudo /usr/bin/killall -q -u chromium
sudo /usr/bin/killall -q -u quite-rss
sudo /usr/bin/killall -q -u tor-browser
sudo /usr/bin/killall -q -u opera

sd /inRam/      &>> /dev/null
sd /inRamA/     &>> /dev/null
sd /inRam-Logs/ &>> /dev/null

sudo /usr/bin/umount -f /inRam
sudo /usr/bin/umount -f /inRamA
sudo /usr/bin/umount -f /inRam-Logs

sudo swapoff -a

sudo bash -i /usr/local/bin/unmount.sh

sudo sdel ndd /var/log

# sudo /usr/bin/umount -f /var/tmp
sudo sdel ndd /var/tmp 			&> /dev/null

sudo /usr/bin/veracrypt -t -d --force &> /dev/null

CD=`sudo veracrypt -t -l | wc -l`
if [ $CD -eq 0  ]; then
	sudo sdel ndd /tmp 			&> /dev/null
fi

sd /home/yandex-disk/.config/yandex-disk/ &>> /dev/null

sd /home/a1/.local/share/keyrings/ &>> /dev/null
sd /home/a1/.local/share/4kdownload.com/ &>> /dev/null
sd /home/a1/.local/share/rhythmbox/ &>> /dev/null
sd /home/a1/.local/ &>> /dev/null

sd /Arcs/swapfile* &> /dev/null

sd /home/a1/ &>> /dev/null
sd /home/first/ &>> /dev/null
sd /home/yandex-disk/ &>> /dev/null

sudo /usr/bin/veracrypt -t -d --force & &> /dev/null

sd /Arcs/Disks/Mega/ &>> /dev/null
sd /Arcs/Disks/ &>> /dev/null
sd /Arcs/tmp/home/ &>> /dev/null

sd /home &>> /dev/null
sd / &>> /dev/null

sudo /usr/sbin/shutdown 0

exit

echo 'exec.sh end'

