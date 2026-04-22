return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	opts = function()
		local actions = require("telescope.actions")
		-- Sharp border characters table
		local sharp_border = {
			"─", -- left
			"│", -- right
			"─", -- top
			"│", -- bottom
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		}

		return {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
				borderchars = sharp_border, -- explicit table avoids string conversion issues
				border = true, -- required when using borderchars
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						borderchars = sharp_border,
						border = true,
					}),
				},
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		require('telescope').load_extension('projects')
	end,
}
