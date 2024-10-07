#!/bin/sh

if pgrep -x "wl-aste" >/dev/null; then
  echo "boo"
    :
else
  echo "poo"
    "wl-paste --primary --watch wl-copy --primary --clear" &
fi
