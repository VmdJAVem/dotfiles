-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.g.godot_executable = "/usr/bin/godot"
vim.cmd("filetype plugin on")
vim.cmd("syntax on")
vim.opt.conceallevel = 2

vim.cmd([[
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE
hi Normal guibg=NONE
hi NormalNC guibg=NONE
]])
