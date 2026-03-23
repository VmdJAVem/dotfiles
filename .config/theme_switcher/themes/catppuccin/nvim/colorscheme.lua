-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
	-- gruvbox
	{
		'datsfilipe/gruvbox.nvim',
		opts = {
			transparency = true,
		}
	},
	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				-- your custom options here
			})
			-- If you want catppuccin as your default instead, change the line below
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
}
