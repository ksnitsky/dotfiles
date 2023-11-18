#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

mode=$1

script_dir="$HOME/.local/share/$mode-mode.d"

if [ ! -d "$script_dir" ]; then
    echo "Directory '$script_dir' does not exist."
    exit 1
fi

for script in "$script_dir"/*.sh; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        "$script"
    else
        echo "Skipping $script, either not executable or not a regular file."
    fi
done
