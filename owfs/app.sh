#!/bin/sh

# Start the first process: owserver
/usr/bin/owserver -c /etc/owfs/owfs.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start 'owserver': $status"
  exit $status
fi

# Start the second process: owhttpd
/usr/bin/owhttpd -c /etc/owfs/owfs.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start 'owhttpd': $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux |grep owserver |grep -q -v grep
  OWSERVER_STATUS=$?
  ps aux |grep owhttpd  |grep -q -v grep
  OWHTTPD_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $OWSERVER_STATUS -ne 0 ]; then
    echo "owserver-process has already exited."
    exit 1
  fi
  if [ $OWHTTPD_STATUS -ne 0 ]; then
    echo "owhttpd-process has already exited."
    exit 1
  fi
done
