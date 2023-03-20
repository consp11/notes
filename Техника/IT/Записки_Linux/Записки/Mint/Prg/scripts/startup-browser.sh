echo 'startup chromium'
echo 'password for br1 required'
su br1 -c 'chromium %U --proxy-server="127.0.0.1:8118"' &

disown -a
