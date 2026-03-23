return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Optional: better performance for certain pickers
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- The ui-select extension
		"nvim-telescope/telescope-ui-select.nvim",
	},
	opts = function()
		-- You can define your Telescope options here.
		-- This function will be called when the plugin loads.
		local actions = require("telescope.actions")

		return {
			defaults = {
				-- Your default configuration
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			extensions = {
				-- Configure the ui-select extension
				["ui-select"] = {
					-- Use the dropdown theme (or any other theme you like)
					require("telescope.themes").get_dropdown({
						-- Additional theme options go here
						-- e.g., winblend = 10, border = true, etc.
					}),
				},
			},
		}
	end,
	config = function(_, opts)
		-- This is the standard way to set up Telescope with opts.
		-- It will merge your opts with the default config.
		require("telescope").setup(opts)

		-- Load the extensions (including ui-select)
		-- Note: pcall is used to avoid errors if an extension isn't installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		require("telescope").load_extension("projects")
	end,
}
