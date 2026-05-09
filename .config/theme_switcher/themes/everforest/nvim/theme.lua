vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "everforest",
	callback = function()
		vim.api.nvim_set_hl(0, 'DashboardHeader', {
			link = 'String'
		})
		local pmenu = vim.api.nvim_get_hl(0, { name = "PmenuSel" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", {
			fg = string.format("#%06x", pmenu.bg),
		})
		local hl = vim.api.nvim_get_hl(0, {
			name = "BlinkCmpSignatureHelpActiveParameter",
		})

		vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", {
			fg = hl.bg,
			bg = hl.fg,
		})
	end
})

-- Defer colorscheme loading to improve startup time
vim.defer_fn(function()
	vim.cmd.colorscheme("everforest")
end, 100)
