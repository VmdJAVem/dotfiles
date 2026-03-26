vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	callback = function()
		local transparent_groups = {
			"Normal",
			"NormalNC",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"EndOfBuffer",
			"MsgArea",
			"WinSeparator",
			"StatusLine",
			"StatusLineNC",
			"Pmenu",
			"PmenuBorder",
		}

		-- make everything transparent
		for _, group in ipairs(transparent_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "NONE" })
		end

		-- keep selection visible
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c3836" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3c3836" })

		-- diagnostics signs (no background blocks)
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "NONE" })

		-- blink.cmp
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })

		-- documentation window
		vim.api.nvim_set_hl(0, "CmpDoc", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "CmpDocBorder", { link = "Pmenu" })

		-- remove ALL kind backgrounds
		local kinds = {
			"Text", "Method", "Function", "Constructor", "Field", "Variable",
			"Class", "Interface", "Module", "Property", "Unit", "Value",
			"Enum", "Keyword", "Snippet", "Color", "File", "Reference",
			"Folder", "EnumMember", "Constant", "Struct", "Event",
			"Operator", "TypeParameter",
		}

		for _, kind in ipairs(kinds) do
			vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { bg = "NONE" })
		end

		-- dashboard color (gruvbox green)
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#b8bb26" })
	end,
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
