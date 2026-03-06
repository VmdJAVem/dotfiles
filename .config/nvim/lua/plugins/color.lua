return {
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			transparent_mode = true,
			contrast = "hard", -- Optional: keep your contrast setting
		},
		-- Ensures gruvbox loads before LazyVim's colorscheme setup
		priority = 1000,
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}
