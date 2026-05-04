vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "everforest",
	callback = function()
		vim.api.nvim_set_hl(0, 'DashboardHeader', {
			link = 'String'
		})
	end
}

)
vim.cmd.colorscheme("everforest")
