#!/usr/bin/env bash

chosen=$(printf "󰐥 Shutdown\n󰜉 Reboot\n󰍃 Logout\n" | \
    tofi --prompt-text "power:" \
         --width 20% \
         --height 30%)

case "$chosen" in
    "󰍃 Logout")
        hyprctl dispatch exit
        ;;

    "󰜉 Reboot")
	    doas reboot
        ;;

    "󰐥 Shutdown")
	    doas poweroff
        ;;
esac
