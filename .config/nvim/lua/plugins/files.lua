return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Replace nvim-web-devicons with mini.icons
		"echasnovski/mini.icons",
		"MunifTanjim/nui.nvim",
		-- for git status in tree:
		{ "sindrets/diffview.nvim", opts = {} }, -- optional, but recommended
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
		{ "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal current file" },
	},
	config = function()
		-- Make mini.icons act like nvim-web-devicons for plugins that still expect it
		require("mini.icons").mock_nvim_web_devicons()

		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- show hidden files
				},
			},
		})
	end,
}
