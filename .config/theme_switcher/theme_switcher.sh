#!/usr/bin/env bash

set -e

FZF_DEFAULT_OPTS="$(tr '\n' ' ' < ~/.config/fzf/current 2>/dev/null)"
export FZF_DEFAULT_OPTS

THEMES_DIR="$HOME/.config/theme_switcher/themes"

THEME=$(find "$THEMES_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | \
    fzf --height 40% \
        --layout reverse \
        --border \
        --prompt 'Theme: ' \
        --preview "ls -l $THEMES_DIR/{}" \
        --preview-window=right:60%:wrap)

[ -z "$THEME" ] && exit 0

BASE_DIR="$THEMES_DIR/$THEME"

echo "Switching to theme: $THEME"


# ------------------------
# HYPRLAND
# ------------------------
ln -sf "$BASE_DIR/hypr/colors.conf" ~/.config/hypr/colors.conf
ln -sf "$BASE_DIR/hypr/hyprtoolkit.conf" ~/.config/hypr/hyprtoolkit.conf

# ------------------------
# KITTY
# ------------------------
ln -sf "$BASE_DIR/kitty/colors.conf" ~/.config/kitty/colors.conf
pgrep -x kitty >/dev/null && kill -SIGUSR1 $(pgrep -x kitty) || true

# ------------------------
# NEOVIM
# ------------------------
ln -sf "$BASE_DIR/nvim/statusline.lua" ~/.config/nvim/lua/plugins/statusline.lua
ln -sf "$BASE_DIR/nvim/theme.lua" ~/.config/nvim/lua/config/theme.lua

# ------------------------
# TMUX
# ------------------------
ln -sf "$BASE_DIR/tmux/colors.conf" ~/.config/tmux/colors.conf

tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null || true

# ------------------------
# WAYBAR
# ------------------------
ln -sf "$BASE_DIR/waybar/style.css" ~/.config/waybar/style.css

pkill waybar 2>/dev/null || true
sleep 0.3
hyprctl dispatch exec waybar
# ------------------------
# GTK
# ------------------------
case "$THEME" in
    catppuccin)
        GTK_THEME="catppuccin-mocha-lavender-standard+default"
	gsettings set org.gnome.desktop.interface icon-theme "Colloid-Purple-Catppuccin-Dark"
        ;;
    gruvbox)
        GTK_THEME="Gruvbox-Green-Dark"
	gsettings set org.gnome.desktop.interface icon-theme  "Colloid-Green-Gruvbox-Dark"
        ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" 2>/dev/null || true

mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

cat > ~/.config/gtk-3.0/settings.ini <<EOF
[Settings]
gtk-theme-name=$GTK_THEME
EOF

cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini

# Wallpaper
#
case "$THEME" in
	catppuccin)
		awww img ~/Wallpapers/Cowboy_Bebop.jpg
		;;
	gruvbox)
		awww img ~/Wallpapers/gruvbox-meadow.jpg
		;;
	esac

#rmpc
		ln -sf "$BASE_DIR/rmpc/colors.ron" ~/.config/rmpc/themes/colors.ron
# swaync
		ln -sf "$BASE_DIR/swaync/style.css" ~/.config/swaync/style.css
		pkill swaync 2>/dev/null || true
		sleep 0.2
		swaync >/dev/null 2>&1 &
echo "REACHED CURRENT WRITE"
echo "$THEME" > "$HOME/.config/theme_switcher/.current"
# ------------------------
# FZF
# ------------------------
FZF_THEME_FILE="$HOME/.config/fzf/themes/$THEME"

if [ -f "$FZF_THEME_FILE" ]; then
    export FZF_DEFAULT_OPTS="$(tr '\n' ' ' < "$FZF_THEME_FILE")"
    ln -sf "$FZF_THEME_FILE" ~/.config/fzf/current
fi

# sioyek
	ln -sf "$BASE_DIR/sioyek/prefs_user.config" ~/.config/sioyek/
# startpage
	ln -sf "$BASE_DIR/startpage/colors.css" ~/startpage/colors.css
# ------------------------
# HYPRLAND reload
# ------------------------
hyprctl reload 2>/dev/null || true

echo "$THEME" > "$HOME/.config/theme_switcher/.current"

echo "Theme applied: $THEME"
