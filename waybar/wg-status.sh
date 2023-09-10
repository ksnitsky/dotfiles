#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <interface_name>"
    exit 1
fi

interface="$1"

if ip route | grep -q "dev $interface"; then
    echo "{\"text\":\" 󰕥 \", \"tooltip\":\"$interface connected\"}"
else
    echo "{\"text\":\" 󰦞 \", \"tooltip\":\"$interface not connected\"}"
fi
