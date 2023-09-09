#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

if [ ! -d "$directory_path" ]; then
    echo "Directory not found: $directory_path"
    exit 1
fi

temperature_file="$directory_path/temp1_input"
usage_file="$directory_path/device/gpu_busy_percent"

if [ ! -f "$temperature_file" ]; then
    echo "GPU temperature file not found: $temperature_file"
    exit 1
fi

if [ ! -f "$usage_file" ]; then
    echo "GPU usage file not found: $usage_file"
    exit 1
fi

value=$(<"$temperature_file")
value="${value//[$'\n']}"
value="${value//[$'\r']}"

if ! [[ $value =~ ^[0-9]+$ ]]; then
    echo "Invalid numeric value in the first file: $value"
    exit 1
fi

temperature=$((value / 1000))

usage=$(<"$usage_file")

echo "$temperature°C | $usage%"
