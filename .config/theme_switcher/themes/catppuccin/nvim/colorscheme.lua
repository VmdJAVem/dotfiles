-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
	-- gruvbox
	{
		"https://gitlab.com/motaz-shokry/gruvbox.nvim",
		name = "gruvbox",
		priority = 1000,
		lazy = true,
		config = function()
			require("gruvbox").setup({
				variant = "hard",
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
				groups = {
					h1 = "green_dark",
					h3 = "green_lite",
				},
			})
		end
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
		opts = {
			flavour = "mocha",
			transparent_background = true
		}
	},
}
