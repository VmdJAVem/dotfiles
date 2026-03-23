return {
	"ahmedkhalf/project.nvim",
	lazy = false,
	config = function()
		require("project_nvim").setup({
			detection_methods = { "lsp", "pattern" },
		})
	end,
}
