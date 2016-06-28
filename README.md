# What is it?
This is a collection of scripts to send out notifications on successful OpenVPN connections over TOR.

# How to use it?
0. Put `tor-alert.sh` and `update-tor-exit-nodes.sh` scripts in a directory of your preference. For example, `/etc/openvpn/`.
0. Go through both scripts and make sure to change settings to fit your environment.
0. Add following entry to your OpenVPN `server.conf` config: `client-connect /etc/openvpn/tor-alert.sh`  
This way `tor-alert.sh`  script would be executed on every successful connection.
0. Configure cron to run `update-tor-exit-nodes.sh` periodically to keep a list of TOR exit nodes updated. For example, use `45  * * * * nobody /etc/openvpn/update-tor-exit-nodes.sh` to run it every hour.

# Any prerequisites?
`tor-alert.sh` script uses `mail` command to send alerts. Therefore, your system MTA should be properly configured.  
Alternatively, you can use some other command to send notifications.

