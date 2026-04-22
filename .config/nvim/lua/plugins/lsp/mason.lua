return {
	"mason-org/mason.nvim",
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
