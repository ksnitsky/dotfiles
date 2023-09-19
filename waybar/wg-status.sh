#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <interface_name>"
    exit 1
fi

interface="$1"

if ip route | grep -q "dev $interface"; then
    echo "{\"alt\":\"connected\", \"tooltip\":\"$interface connected\"}"
else
    echo "{\"alt\":\"disconnected\", \"tooltip\":\"$interface not connected\"}"
fi
