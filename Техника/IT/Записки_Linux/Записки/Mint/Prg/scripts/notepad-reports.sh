/usr/lib/notepadqq/notepadqq-bin --new-window '/A/service/aide/report.log' '/inRam/aide-clamav.log' '/inRam/cp-git-h.log' &  &> /inRam/startup-nqq-pl.log

xfce4-terminal --tab -T 'aide-clamav.log' -x watch 'cat /inRam/aide-clamav.log | tail -n 25' &
/home/main/bin/waitwindow.sh 'aide-clamav.log'

xfce4-terminal --tab -T '/inRam/cp-git-h.log' -x watch 'cat /inRam/cp-git-h.log | tail -n 25' &
xfce4-terminal --tab -T '/inRam-Logs/upgrade' -x watch 'cat /inRam-Logs/upgrade | tail -n 25' &
