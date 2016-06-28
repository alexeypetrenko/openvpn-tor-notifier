#!/bin/sh

ALERT_RECEPIENT="CHANGEME@example.com"
TOR_EXIT_NODES_FILE="/tmp/tor-exit.lst"
WORKING_DIR="/tmp/tor-remote-alert/"
URL="https://example.com/openvpn.log"
AUTH="user:password"

if [ ! -d "$WORKING_DIR" ]; then
  echo "Directory $WORKING_DIR doesn't exist"
  exit 1
fi
cd $WORKING_DIR

if [ ! -f "$TOR_EXIT_NODES_FILE" ]; then
  echo "File $TOR_EXIT_NODES_FILE doesn't exist"
  exit 1
fi

LOGFILE="openvpn.log"

SKIP=0
if [ -f "$LOGFILE" ]; then
  SKIP=$(stat -c%s $LOGFILE)
fi

curl -sS $URL -u $AUTH > $LOGFILE
if [ $? -ne 0 ]; then
  exit $?
fi

if [ $(stat -c%s $LOGFILE) -lt $SKIP ]; then
  # New file is smaller than the old one. Resetting SKIP.
  SKIP=0
fi

DATA=$(tail -c +$SKIP $LOGFILE | grep -F 'succeeded for username' | grep -Ff $TOR_EXIT_NODES_FILE | awk '{print $1,$2,$3,$4,$5,"User "$13" is using TOR [IP: "$6"]"}')

if [ ! -z "$DATA" ]; then
  echo "$DATA" | mail -S 'VPN connection from TOR exit node' $ALERT_RECEPIENT
fi
