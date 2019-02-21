#!/bin/sh

cp -r /config/asterisk/* /data/asterisk/.
cp -r /config/owfs/* /data/owfs/.
cp -r /config/openhab/* /data/openhab/.
cp -r /config/mosquitto/* /data/mosquitto/.
cp -r /config/signal/* /data/signal/.

/usr/sbin/sshd -p 22 &

echo "This is where your application would start..."
while : ; do
  echo "waiting"
  sleep 60
done
