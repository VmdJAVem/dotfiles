Terminal = "kitty"
FileManager = "pcmanfm"
Menu = '$(tofi-drun)'
Player = "cmus"
Browser = "qutebrowser"
TextEditor = "emacsclient -c -n"
Wall_change =
"~/.config/theme_switcher/wall_switcher.sh ~/Wallpapers/ $(cat ~/.config/theme_switcher/.current) awww img"
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
	hl.exec_cmd("emacs --daemon")
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
	input = {
		kb_options = "compose:ralt"

	}
})
-- animations
require("animations")
