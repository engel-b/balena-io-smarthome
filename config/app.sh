#!/bin/sh

echo "This is where your application would start..."
while : ; do
  cd /data
  git pull
  echo "waiting"
  sleep 60
done
