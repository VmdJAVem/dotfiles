Terminal = "kitty"
FileManager = "thunar"
Menu = 'tofi-drun | while read -r cmd; do hyprctl dispatch exec "$cmd"; done'
Player = "cmus"
Browser = "qutebrowser"
TextEditor = "nvim"
Play = [[
selected="$(mpc listall | tofi --prompt-text 'play:')";
[ -n "$selected" ] && mpc add "$selected" && mpc play
]]
Wall_change =
"~/.config/theme_switcher/wall_switcher.sh ~/Wallpapers/Wallpapers $(cat ~/.config/theme_switcher/.current) awww img"
PdfReader = "sioyek"

Exec = hl.dsp.exec_cmd
Exec_raw = hl.dsp.exec_raw


-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("mpd ~/.config/mpd/mpd.conf")
	hl.exec_cmd("mpDris2")
	hl.exec_cmd("qs")
	hl.exec_cmd("hyprsunset -g 90 -t 5300")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("vesktop --start-minimized")
	hl.exec_cmd("sh -c 'cd ~/.config/omnisearch/; omnisearch'")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("dunst")
	hl.exec_cmd(".config/hypr/openrgb-login.sh")
end)

hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- source other files
local c = require("colors")
require("binds")

-- General config

print(c.active_border)
hl.config({
	general = {
		border_size = 1,
		layout = "master",
		gaps_in = 5,
		gaps_out = 8,
		resize_on_border = true,
		allow_tearing = true,

		col = {
			active_border = c.border_active,
			inactive_border = c.border_inactive,
		},
	},
	decoration = {
		rounding         = 1,
		rounding_power   = 1,

		active_opacity   = c.active_opacity,
		inactive_opacity = c.active_opacity,

		blur             = {
			enabled = true,
			size = 4,
			passes = 2,
			xray = true,
		},
		shadow           = {
			enabled = false
		}

	},
})
hl.curve("smooth", {
	type = "bezier",
	points = {
		{ 0.25, 0.1 },
		{ 0.25, 1.0 }
	}
})

hl.curve("fast", {
	type = "bezier",
	points = {
		{ 0.3,  0.0 },
		{ 0.15, 1.0 }
	}
})

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 3,
	curve = "smooth",
	style = "popin 96%",
	bezier = "fast"
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 2,
	curve = "fast",
	style = "popin 96%",
	bezier = "smooth"
})

hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 2,
	curve = "smooth",
	bezier = "smooth"
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3,
	curve = "smooth",
	style = "slidefade 8%",
	bezier = "fast"
})
