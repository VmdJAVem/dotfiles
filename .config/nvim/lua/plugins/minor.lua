return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		--@module "ibl"
		--@type ibl.config
		opts = {
			-- your other options
			exclude = {
				filetypes = {
					"dashboard", -- if you use dashboard.nvim
					"alpha", -- if you use alpha-nvim
					"help",
					"lspinfo",
					"TelescopePrompt",
					"NvimTree",
					"neo-tree",
					"toggleterm",
					-- add any other buffer types where you don't want guides
				},
				buftypes = { "terminal", "nofile", "prompt" },
			},
		},
	}
}
