#!/bin/bash

echo "What do you wish to connect to?"

read -p -r "laptop wi-fi, laptop ethernet or desktop ethernet (lw, le, de)" device

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

find_device () {
  network_range="10.0.0.0/24" 
  scan_results=$(sudo nmap -sn --send-eth $network_range)
  processed_results=$(echo "$scan_results" | awk '/Nmap scan report/{ip=$NF}/MAC Address:/{print ip, $3}')
  found=0 
  while IFS= read -r line; do
    if [[ $line == *$1* ]]; then
        found=1
        ip_address=$(echo "$line" | awk '{print $1}')
         
    fi
  done <<< "$processed_results"
  if [[ $found -eq 0 ]]; then
    echo "Device with MAC address $1 not found."
  fi
} 
