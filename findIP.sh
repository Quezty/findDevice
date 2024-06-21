#!/bin/bash

# Define the network range and the MAC address to search for
network_range="10.0.0.0/24"  # Replace with your network range
target_mac="D8:5E:D3:AE:A0:4F"  # Replace with the MAC address you're looking for

# Run the nmap command and assign the output to a variable
scan_results=$(sudo nmap -sn --send-eth $network_range)

# Process the scan results to extract IP and MAC addresses
processed_results=$(echo "$scan_results" | awk '/Nmap scan report/{ip=$NF}/MAC Address:/{print ip, $3}')

# Check if the processed results contain the target MAC address
found=0

# Loop through each line of the processed results
while IFS= read -r line; do
    if [[ $line == *$target_mac* ]]; then
        found=1
        ip_address=$(echo "$line" | awk '{print $1}')

        echo "$ip_address"
    fi
done <<< "$processed_results"

# If the MAC address was not found, print a message
if [[ $found -eq 0 ]]; then
    echo "Device with MAC address $target_mac not found."
fi
