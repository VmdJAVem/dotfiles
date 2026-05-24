#!/bin/sh

if ! command -v playerctl >/dev/null 2>&1; then
	echo "󰽬 no player"
	exit 0
fi

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
	artist=$(playerctl metadata artist 2>/dev/null)
	title=$(playerctl metadata title 2>/dev/null)

	if [ -n "$artist" ] || [ -n "$title" ]; then
		echo "󰽬 $artist - $title"
	else
		echo "󰽬"
	fi
else
	echo "󰽬"
fi
