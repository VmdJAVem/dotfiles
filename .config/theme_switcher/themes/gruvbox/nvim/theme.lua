-- transparency + highlight fixes
vim.api.nvim_create_autocmd("ColorScheme", {
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

		-- preserve fg, remove bg
		for _, group in ipairs(transparent_groups) do
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
			if ok and hl then
				vim.api.nvim_set_hl(0, group, {
					fg = hl.fg,
					bg = "NONE",
				})
			else
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end
		end

		-- keep selection visible (gruvbox hard)
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3c3836" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3c3836" })

		-- diagnostics (no background blocks, keep fg)
		for _, group in ipairs({
			"DiagnosticSignError",
			"DiagnosticSignWarn",
			"DiagnosticSignInfo",
			"DiagnosticSignHint",
		}) do
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
			if ok and hl then
				vim.api.nvim_set_hl(0, group, {
					fg = hl.fg,
					bg = "NONE",
				})
			end
		end

		-- blink.cmp
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "PmenuBorder" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })

		-- documentation window
		vim.api.nvim_set_hl(0, "CmpDoc", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "CmpDocBorder", { link = "PmenuBorder" })

		-- remove backgrounds from completion kinds
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
-- colorscheme
vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")
