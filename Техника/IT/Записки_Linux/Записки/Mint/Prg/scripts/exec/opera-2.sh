cd ~

# cd /home/main/users/tor-browser

# nice -n 18 opera
sudo systemd-run --scope --nice=18 --uid=opera --gid=opera -p CPUQuota=40% opera

disown -a

