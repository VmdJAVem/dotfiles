-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
	-- gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				transparent_mode = true, -- built-in option
			})
		end,
	},
	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				float = {
					transparent = true, -- enable transparent floating windows
					solid = true, -- use solid styling for floating windows, see |winborder|

				},
			})
		end,
	},
}
