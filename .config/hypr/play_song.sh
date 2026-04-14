#!/usr/bin/env zsh

echo "$FZF_DEFAULT_OPTS"
set -e

mpc clear
selection=$(mpc listall | fzf -m \
    --height 100% \
    --layout reverse \
    --prompt="queue > " \
    --border=sharp \
)
[ -z "$selection" ] && exit 0

# Add selections to queue (no clear)
echo "$selection" | while IFS= read -r line; do
    mpc add "$line"
done
# Play only if not already playing
if ! mpc status | grep -q "\[playing\]"; then
    mpc play >/dev/null
fi
