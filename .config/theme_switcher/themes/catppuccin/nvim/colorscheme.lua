-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
	-- gruvbox
	{
		"morhetz/gruvbox",
		opts = {

		}
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
	-- everforest
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				background = "hard",
				transparent_background_level = 2,
				italics = true,

			})
		end
	}
}
