
# bash /home/main/bin/ping.sh

# Ожидаем появления интернета
ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'
while [ $? -ne 0 ]
do
  sleep 5
  ping -s 16 -c 1 77.88.8.88 | egrep -o '(time=.*|.*no answer.*)'

  # Раз в пять секунд, так как иначе, если запущено сразу несколько скриптов, то они могут вызвать access denied
done
