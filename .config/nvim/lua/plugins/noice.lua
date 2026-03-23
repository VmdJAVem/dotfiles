return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline",
		},
		messages = {
			enabled = true,
		},
		popupmenu = {
			enabled = false,
		},
		-- Disable select/input overrides so Telescope handles them
		ui = {
			select = false,
			input = false,
		},
		lsp = {
			signature = { enabled = false } -- 添加此行 - deepseek
		}
		-- other options...
	},
}
