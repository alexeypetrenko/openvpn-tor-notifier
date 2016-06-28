# What is it?
This is a collection of scripts to send out notifications on successful OpenVPN connections over TOR.

**Scripts in this branch are meant to be run on a separate server, having OpenVPN logs shared via HTTP(S).**

# How to use it?
0. Put `tor-remote-alert.sh` and `update-tor-exit-nodes.sh` scripts in a directory of your preference.
0. Go through both scripts and make sure to change settings to fit your environment.
0. Configure cron to run `update-tor-exit-nodes.sh` periodically to keep a list of TOR exit nodes updated. For example, use `45  * * * * nobody /your_path/update-tor-exit-nodes.sh` to run it every hour.
0. Configure cron to run `tor-remote-alert.sh` periodically.

# Any prerequisites?
`tor-alert.sh` script uses `mail` command to send alerts. Therefore, your system MTA should be properly configured.  
Alternatively, you can use some other command to send notifications.

