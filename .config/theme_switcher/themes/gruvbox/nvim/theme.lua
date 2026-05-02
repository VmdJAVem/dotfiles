vim.cmd.colorscheme("gruvbox")

local groups = {
	"MiniClueTitle"
}

for _, group in ipairs(groups) do
	local old = vim.api.nvim_get_hl(0, { name = group })

	local hl = vim.tbl_extend("force", old, {
		bg = "none",
	})

	vim.api.nvim_set_hl(0, group, hl)
end
vim.api.nvim_set_hl(0, "DashboardHeader", {
	link = "String"
})
local err = vim.api.nvim_get_hl(0, { name = 'ErrorMsg' })
vim.api.nvim_set_hl(0, 'MiniHipatternsFixme', {
	italic = true,
	underline = true,
	fg = err.fg
})
local yell = vim.api.nvim_get_hl(0, { name = 'Question' })
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
-- NOTE TODO HACK FIXME
vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', {
	link = 'RenderMarkdownH2Bg'
})
-- vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', {
-- 	link = 'RenderMarkdownH2Bg'
-- })
-- vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', {
-- 	link = 'RenderMarkdownH2Bg'
-- })
-- vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', {
-- 	link = 'RenderMarkdownH2Bg'
-- })
