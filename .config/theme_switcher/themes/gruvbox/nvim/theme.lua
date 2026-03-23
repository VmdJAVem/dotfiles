vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local groups = {
			"Normal",
			"NormalNC",
			"MsgArea",
			"NormalFloat",
			"FloatBorder",
			"SignColumn",
			"EndOfBuffer",
			"WinSeparator",
			"StatusLine",
			"StatusLineNC",
		}

		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end

		-- diagnostics
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "none" })

		vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
		-- docs
		vim.api.nvim_set_hl(0, "CmpDoc", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "CmpDocBorder", { link = "Pmenu" })
	end,
})
vim.cmd.colorscheme("gruvbox")
