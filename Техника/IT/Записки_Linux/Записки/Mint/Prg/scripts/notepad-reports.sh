# /usr/lib/notepadqq/notepadqq-bin --new-window '/A/service/aide/report.log' '/inRam/aide-clamav.log' &  &> /inRam/startup-nqq-pl.log

xfce4-terminal --tab -T 'aide-clamav.log' -x watch -n 16 'cat /inRam/aide-clamav.log | tail -n 25' &
/home/main/bin/waitwindow.sh 'aide-clamav.log'
sleep 1

xfce4-terminal --tab -T '/inRam/cp-git-h.log' -x watch -n 16 'cat /inRam/cp-git-h.log | tail -n 25' &
xfce4-terminal --tab -T '/inRam-Logs/upgrade' -x watch -n 16 'cat /inRam-Logs/upgrade | tail -n 25' &
