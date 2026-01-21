-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.godot_executable = "/usr/bin/godot"
vim.cmd("filetype plugin on")
vim.cmd("syntax on")
