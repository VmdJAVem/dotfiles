return {
	"mason-org/mason.nvim",
	event = "VeryLazy",
	opts = {
		ui               = {
			backdrop = 50,
		},
		ensure_installed = {
			"lua-language-server",
			"clangd",
			"haskell-language-server",
		}
	}
}
