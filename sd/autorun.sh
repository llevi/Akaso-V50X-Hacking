#!/bin/sh

# USAGE
# Start AP mode with the camera GUI immediately after bootup and exit immediately
# no dhcp support yet

sleep 5
/app/sd/lib/wpa_supplicant -B -i wlan0 -c /app/sd/lib/wpa_supplicant.conf -D nl80211 -f /app/sd/lib/wpa.log
ip addr del 192.168.0.1/24 dev wlan0
ip addr add xx.xx.xx.xx/24 dev wlan0
ip link set wlan0 up

tcpsvd -vE 0.0.0.0 21 ftpd -w /app/sd &

## If you want to write your ip to the screen
#kill -STOP 141
#/app/sd/lib/fbtext "IP: $(ip a show wlan0 | sed -n 's/.*inet \([0-9.]*\/[0-9]*\).*/\1/p') PORTS: $(netstat -lnp | sed -n 's/^[^ ]*[ ]*[0-9]*[ ]*[0-9]*[ ]*0.0.0.0:\([0-9]*\).*/\1/p' | tr '\n' ' ')"
#sleep 5
#kill -CONT 141
