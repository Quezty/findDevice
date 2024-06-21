# !/bin/bash

echo "What do you wish to connect to?"

read -p "laptop wi-fi, laptop ethernet or desktop ethernet (lw, le, de)" device

case "$device" in
  "lw") 
    echo "lw"
    ;;
  "le") 
    echo "le" 
    ;;
  "de")
    echo "de"
    ;;
  *) 
    echo default
    ;;
esac

find_device (MAC_ADDRESS) {
  network_range="10.0.0.0/24" 
  scan_results=$(sudo nmap -sn --send-eth $network_range)
  processed_results=$(echo "$scan_results" | awk '/Nmap scan report/{ip=$NF}/MAC Address:/{print ip, $3}')

} 
