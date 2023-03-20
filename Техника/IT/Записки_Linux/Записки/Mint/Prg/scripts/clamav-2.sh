sudo -u clamav freshclam >& /inRam/clamav.log

# sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=yes --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/bin /usr/sbin /usr/**/bin /usr/**/sbin /usr/lib* /usr/local/lib* /opt >>& /inRam/clamav.log

# sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/bin /usr/sbin /usr/**/bin /usr/**/sbin /opt &>> /inRam/clamav.log

sudo clamscan -iozr --follow-dir-symlinks=2 --follow-file-symlinks=2 --max-filesize=256M --max-scansize=256M --max-recursion=128 --max-dir-recursion=128 --alert-encrypted=no --alert-broken=yes --pcre-match-limit=200000 --pcre-recmatch-limit=10000 --pcre-max-filesize=256M --bytecode-timeout=600000 /usr/sbin /usr/**/bin /usr/**/sbin /opt &>> /inRam/clamav.log

# /usr/sbin /usr/**/bin /usr/**/sbin &>> /inRam/clamav.log
