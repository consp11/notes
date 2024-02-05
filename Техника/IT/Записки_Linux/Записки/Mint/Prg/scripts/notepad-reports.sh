/usr/lib/notepadqq/notepadqq-bin --new-window '/A/service/aide/report.log' '/inRam/aide-clamav.log' '/inRam/cp-git-h.log' &  &> /inRam/startup-nqq-pl.log

xfce4-terminal --tab -x watch 'cat /inRam/aide-clamav.log | tail -n 25' &
xfce4-terminal --tab -x watch 'cat /inRam/cp-git-h.log | tail -n 25' &
xfce4-terminal --tab -x watch 'cat /inRam-Logs/upgrade | tail -n 25' &
