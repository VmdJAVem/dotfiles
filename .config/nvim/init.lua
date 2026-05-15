require("config.lazy")

vim.opt.fillchars:append({ eob = " " })

vim.treesitter.language.register("markdown", "vimwiki")
require("config.keymaps")
require("config.options")
require("config.cmdline")
require("config.theme")
vim.opt.runtimepath:append("~/.local/share/nvim/site")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.opt.spell = true
vim.opt.spelllang = 'es,en'
