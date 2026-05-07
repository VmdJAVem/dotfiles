#! /usr/bin/env bash

WALLPAPER_DIR="$1"
THEME="$2"
shift 2
WALL_UTIL_ARGS=("$@")


WALL=$(find "$WALLPAPER_DIR/$THEME" \
    -mindepth 1 -maxdepth 1 -type f -printf "%f\n" | \
    tofi --prompt-text "wall: "
)

[ -z "$WALL" ] && exit 0

"${WALL_UTIL_ARGS[@]}" "$WALLPAPER_DIR/$THEME/$WALL"
