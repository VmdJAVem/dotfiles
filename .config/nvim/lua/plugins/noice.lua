return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/snacks.nvim",
		},
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline"
			},
			notify = {
				enabled = true,
				view = "notify",
			},
		},
	},
}
