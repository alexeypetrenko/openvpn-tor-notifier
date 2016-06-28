#!/bin/sh

ALERT_RECEPIENT="CHANGEME@example.com"
TOR_EXIT_NODES_FILE="/tmp/tor-exit.lst"

if [ -z "$username" ]; then
  echo "$0: Environment variable \$username is not set for some reason"
  PRECHECK_FAILED=1
fi
if [ -z "$trusted_ip" ]; then
  echo "$0: Environment variable \$trusted_ip is not set for some reason"
  PRECHECK_FAILED=1
fi
if [ ! -f "$TOR_EXIT_NODES_FILE" ]; then
  echo "$0: File $TOR_EXIT_NODES_FILE doesn't exist"
  PRECHECK_FAILED=1
fi
if [ ! -z "$PRECHECK_FAILED" ]; then
  # Returning 0 so that user is not disconnected on a script failure
  exit 0
fi

function do_stuff() {
  grep -Fqs $trusted_ip $TOR_EXIT_NODES_FILE
  if [ $? -eq 0 ]; then
    echo "User $username is using TOR [IP: $trusted_ip]" | mail -S 'VPN connection from TOR exit node' $ALERT_RECEPIENT
  fi
}

do_stuff &
exit 0
