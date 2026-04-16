vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")
local err = vim.api.nvim_get_hl(0, { name = 'ErrorMsg' })
vim.api.nvim_set_hl(0, 'MiniHipatternsFixme', {
	italic = true,
	underline = true,
	fg = err.bg
})
local yell = vim.api.nvim_get_hl(0, { name = 'Search' })
vim.api.nvim_set_hl(0, 'MiniHipatternsHack', {
	italic = true,
	underline = true,
	fg = yell.fg
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

vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', {
	link = 'RenderMarkdownH2Bg'
})
vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', {
	link = 'RenderMarkdownH2Bg'
})
vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', {
	link = 'RenderMarkdownH2Bg'
})
vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', {
	link = 'RenderMarkdownH2Bg'
})
