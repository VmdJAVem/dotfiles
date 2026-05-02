vim.cmd.colorscheme("catppuccin-mocha")
local groups = {
	"Normal",
	"NormalNC",
	"Comment",
	"Constant",
	"Special",
	"Identifier",
	"Statement",
	"PreProc",
	"Type",
	"Underlined",
	"Todo",
	"String",
	"Function",
	"Conditional",
	"Repeat",
	"Operator",
	"Structure",
	"LineNr",
	"NonText",
	"SignColumn",
	"CursorLine",
	"CursorLineNr",
	"StatusLine",
	"StatusLineNC",
	"EndOfBuffer",

	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"FloatFootnote",
	"LspHoverFloat",
	"LspFloatWinBorder",
	"LspFloatWinNormal",
	"BlinkCmpMenu",
	"BlinkCmpMenuNormal",
	"BlinkCmpMenuNormalNC",
	"BlinkCmpMenuBorder",
	"BlinkCmpMenuSelection",
	"BlinkCmpMenuSelectionNC",
	"BlinkCmpDoc",
	"BlinkCmpDocNormal",
	"BlinkCmpDocNormalNC",
	"BlinkCmpDocBorder",
	"BlinkCmpDocCursorLine",
	"BlinkCmpDocSeparator",
	"BlinkCmpSignatureHelp",
	"BlinkCmpSignatureHelpNormal",
	"BlinkCmpSignatureHelpNormalNC",
	"BlinkCmpSignatureHelpBorder",
	"BlinkCmpSignatureHelpActiveParameter",
	"BlinkCmpGhostText",
	"BlinkCmpLabel",
	"BlinkCmpLabelDetail",
	"BlinkCmpLabelDescription",
	"BlinkCmpLabelMatch",
	"BlinkCmpLabelDeprecated",
	"BlinkCmpKind",
	"BlinkCmpSource",
	"BlinkCmpScrollBarThumb",
	"BlinkCmpScrollBarGutter",
	"MiniFilesTitleFocused"
}

for _, group in ipairs(groups) do
	local old = vim.api.nvim_get_hl(0, { name = group })

	local hl = vim.tbl_extend("force", old, {
		bg = "none",
	})

	vim.api.nvim_set_hl(0, group, hl)
end

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
