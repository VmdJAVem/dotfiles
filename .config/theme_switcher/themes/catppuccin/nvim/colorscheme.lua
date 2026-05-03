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
				dark_variant = "hard",
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
				groups = {
					-- UI Elements
					border = "gray",
					link = "purple_lite",
					panel = "bg_second",

					-- Diagnostic levels
					error = "red_lite",
					hint = "aqua_lite",
					info = "blue_lite",
					ok = "green_lite",
					warn = "yellow_lite",
					note = "yellow_dark",
					todo = "aqua_dark",

					-- Git states
					git_add = "green_dark",
					git_change = "yellow_dark",
					git_delete = "red_dark",
					git_dirty = "orange_dark",
					git_ignore = "gray",
					git_merge = "purple_dark",
					git_rename = "blue_dark",
					git_stage = "purple_dark",
					git_text = "yellow_lite",
					git_untracked = "bg2",

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
