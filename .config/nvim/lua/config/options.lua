-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.termguicolors = true
vim.o.tabstop = 8       -- Each TAB character displays as 4 columns
vim.o.expandtab = false -- Insert TAB characters instead of spaces
vim.o.softtabstop = 0   -- Disable space/TAB hybrid behavior
vim.o.shiftwidth = 8    -- Number of columns for auto-indent and >>/<< operations
vim.opt.wrap = false    -- disable line wrapping globally
vim.opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"help",
	"globals",
	"skiprtp",
	"folds",
	"localoptions",
}
vim.api.nvim_create_autocmd("FileType", {
	pattern = "haskell",
	callback = function()
		vim.opt_local.expandtab = true -- use spaces for indentation
		vim.opt_local.shiftwidth = 2 -- indent width for >>, <<, etc.
		vim.opt_local.softtabstop = 2 -- make Tab key insert 2 spaces
		vim.opt_local.tabstop = 2 -- how a literal TAB character displays (optional)
	end,
})
vim.opt.clipboard = "unnamedplus" -- use the system clipboard for yank/paste
