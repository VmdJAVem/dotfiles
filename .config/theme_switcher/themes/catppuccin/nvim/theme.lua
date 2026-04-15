vim.cmd.colorscheme("catppuccin-nvim")
local err = vim.api.nvim_get_hl(0, { name = 'ErrorMsg' })
vim.api.nvim_set_hl(0, 'MiniHipatternsFixme', {
	italic = true,
	underline = true,
	fg = err.fg
})
local yell = vim.api.nvim_get_hl(0, { name = 'IncSearch' })
vim.api.nvim_set_hl(0, 'MiniHipatternsHack', {
	italic = true,
	underline = true,
	fg = yell.bg
})
local con = vim.api.nvim_get_hl(0, { name = 'Include', link = false })
vim.api.nvim_set_hl(0, 'MiniHipatternsTodo', {
	italic = true,
	underline = true,
	fg = con.fg
})
local char = vim.api.nvim_get_hl(0, { name = 'Title', link = false })
vim.api.nvim_set_hl(0, 'MiniHipatternsNote', {
	italic = true,
	underline = true,
	fg = char.fg
})
