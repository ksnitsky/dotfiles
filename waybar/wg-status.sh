#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <interface_name>"
    exit 1
fi

interface="$1"

if ip route | grep -q "dev $interface"; then
    # If WireGuard is connected, disconnect it
    wg-quick down "$interface"
else
    # If WireGuard is disconnected, connect it
    wg-quick up "$interface"
fi
