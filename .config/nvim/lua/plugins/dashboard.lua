return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = {
		-- Replace nvim-web-devicons with mini.icons
		"echasnovski/mini.icons",
	},
	config = function()
		-- Only show dashboard if no files were passed to nvim
		if #vim.fn.argv() == 0 then
			require("mini.icons").mock_nvim_web_devicons()

			require("dashboard").setup({
				theme = "hyper",
				config = {
					header = {
						"      ████ ██████           █████      ██                 btw",
						"     ███████████             █████                            ",
						"     █████████ ███████████████████ ███   ███████████  ",
						"    █████████  ███    █████████████ █████ ██████████████  ",
						"   █████████ ██████████ █████████ █████ █████ ████ █████  ",
						" ███████████ ███    ███ █████████ █████ █████ ████ █████ ",
						"██████  █████████████████████ ████ █████ █████ ████ ██████",
						"",
						"",
					},
					project = {
						enable = false,
					},
					shortcut = {
						{
							desc = "Projects",
							action = "Telescope projects",
							key = "p",
						},
						{
							desc = "󰊳 Update",
							group = "@property",
							action = "Lazy update",
							key = "u",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = "Quit",
							group = "q",
							action = "qa",
							key = "q",
						},
					},
					footer = {
						"History will not forgive us if we do not assume power now.",
					},
				},
				hide = { false },
				shortcut_type = "number",
			})
		end
	end,
}
