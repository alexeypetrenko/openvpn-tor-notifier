#!/bin/sh
TOR_EXIT_NODES_FILE="/tmp/tor-exit.lst"
SERVER_IP=8.8.8.8
SERVER_PORT=443
curl -sSL https://check.torproject.org/exit-addresses | grep -F ExitAddress | awk '{print $2}' > "${TOR_EXIT_NODES_FILE}.raw"
curl -sSL "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=${SERVER_IP}&port=${SERVER_PORT}" | grep -vE '^\s*#' >> "${TOR_EXIT_NODES_FILE}.raw"

sort -u < "${TOR_EXIT_NODES_FILE}.raw" > ${TOR_EXIT_NODES_FILE}
rm "${TOR_EXIT_NODES_FILE}.raw"
