-- Keybinds
MainMod = "SUPER + "
MainModShift = MainMod .. "SHIFT + "

hl.bind(MainMod .. "q", Exec(Terminal))
hl.bind(MainMod .. "c", hl.dsp.window.close())
hl.bind(MainMod .. "x", Exec(FileManager))
hl.bind(MainMod .. "e", Exec(Terminal .. " -e " .. TextEditor))
hl.bind(MainMod .. "r", Exec(Menu))
hl.bind(MainMod .. "a", Exec(PdfReader))
hl.bind(MainMod .. "d", Exec(Browser))
hl.bind(MainMod .. "v", hl.dsp.window.float("toggle"))

hl.bind(MainMod .. "SHIFT + Print", Exec("hyprshot -m region -o ~/Pictures/Screenshots/"))

hl.bind(MainModShift .. "h", hl.dsp.window.move({ direction = "left" }))
hl.bind(MainModShift .. "l", hl.dsp.window.move({ direction = "right" }))
hl.bind(MainModShift .. "k", hl.dsp.window.move({ direction = "up" }))
hl.bind(MainModShift .. "j", hl.dsp.window.move({ direction = "down" }))


hl.bind(MainMod .. "h", hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. "l", hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. "k", hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. "j", hl.dsp.focus({ direction = "down" }))

hl.bind(MainMod .. "1", hl.dsp.focus({ workspace = 1 }))
hl.bind(MainMod .. "2", hl.dsp.focus({ workspace = 2 }))
hl.bind(MainMod .. "3", hl.dsp.focus({ workspace = 3 }))
hl.bind(MainMod .. "4", hl.dsp.focus({ workspace = 4 }))
hl.bind(MainMod .. "5", hl.dsp.focus({ workspace = 5 }))
hl.bind(MainMod .. "6", hl.dsp.focus({ workspace = 6 }))
hl.bind(MainMod .. "7", hl.dsp.focus({ workspace = 7 }))
hl.bind(MainMod .. "8", hl.dsp.focus({ workspace = 8 }))
hl.bind(MainMod .. "9", hl.dsp.focus({ workspace = 9 }))
hl.bind(MainMod .. "0", hl.dsp.focus({ workspace = 10 }))

hl.bind(MainModShift .. "1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(MainModShift .. "2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(MainModShift .. "3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(MainModShift .. "4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(MainModShift .. "5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(MainModShift .. "6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(MainModShift .. "7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(MainModShift .. "8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(MainModShift .. "9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(MainModShift .. "0", hl.dsp.window.move({ workspace = 10 }))


hl.bind(MainModShift .. "n", Exec("player previous"))
hl.bind(MainModShift .. "m", Exec("player next"))
hl.bind(MainMod .. "period", Exec("player toggle"))
hl.bind(MainMod .. "n", Exec("player volume -5"))
hl.bind(MainMod .. "m", Exec("player volume +5"))

hl.bind(MainMod .. "s", Exec("~/.config/theme_switcher/theme_switcher.sh"))
hl.bind(MainMod .. "f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(MainMod .. "b", Exec(Play))
hl.bind(MainMod .. "w", Exec(Wall_change))
hl.bind(MainMod .. "p", Exec("~/.config/hypr/power.sh"))


-- SUBMAP: resize
hl.bind(MainMod .. "i", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- SUBMAP: orient
hl.bind(MainMod .. "Tab", hl.dsp.submap("orient"))

hl.define_submap("orient", function()
	hl.bind("l", hl.dsp.layout("orientationright"))
	hl.bind("h", hl.dsp.layout("orientationleft"))
	hl.bind("j", hl.dsp.layout("orientationbottom"))
	hl.bind("k", hl.dsp.layout("orientationtop"))
	hl.bind("c", hl.dsp.layout("orientationcenter"))

	hl.bind("escape", hl.dsp.submap("reset"))
end)
