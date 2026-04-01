require("config.lazy")

vim.opt.fillchars:append({ eob = " " })

vim.treesitter.language.register("markdown", "vimwiki")
vim.diagnostic.config({
	virtual_text = true,
})
require("config.keymaps")
require("config.options")
require("config.theme")
vim.opt.runtimepath:append("~/.local/share/nvim/site")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
