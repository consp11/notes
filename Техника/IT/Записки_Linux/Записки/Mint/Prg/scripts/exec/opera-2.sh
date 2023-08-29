#!/bin/bash
cd ~

# cd /home/main/users/tor-browser

# nice -n 18 opera
percent='38%'
# percent='70%'
sudo systemd-run --scope --nice=18 --uid=opera --gid=opera -p CPUQuota=$percent -p CPUQuotaPeriodSec=1000ms opera


disown -a
