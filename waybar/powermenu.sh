#!/bin/bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | tofi | awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
		swaylock
                ;;
        logout)
                swaymsg exit
                ;;
esac
