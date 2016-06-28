#!/bin/sh
TOR_EXIT_NODES_FILE="/tmp/tor-exit.lst"
curl -sSL https://check.torproject.org/exit-addresses | grep -F ExitAddress | awk '{print $2}' | sort -u > $TOR_EXIT_NODES_FILE
