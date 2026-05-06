vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "everforest",
	callback = function()
		vim.api.nvim_set_hl(0, 'DashboardHeader', {
			link = 'String'
		})
	end
})

-- Defer colorscheme loading to improve startup time
vim.defer_fn(function()
	vim.cmd.colorscheme("everforest")
end, 100)
