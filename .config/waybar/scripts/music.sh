#!/bin/sh

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

echo "󰽬 ${artist} - ${title}"
