return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			html = { "prettier" },
			css = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--tab-width", "8", "--use-tabs" }
			},
		},
	}
}
