#!/bin/sh

# set timezone with TZ (eg. TZ=America/Toronto)
if [ -n "${TZ}" ]
then
	ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime
	echo "${TZ}" > /etc/timezone
fi

echo "This is where your application would start..."
#git clone ssh://git@192.168.150.101:/volume1/homes/git/repos/smarthome-config
#cd smarthome-config
while : ; do
  cd /data


  echo "waiting"
  sleep 60
done
