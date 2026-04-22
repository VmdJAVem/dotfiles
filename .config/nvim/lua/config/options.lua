-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.termguicolors = true
vim.o.tabstop = 8       -- Each TAB character displays as 4 columns
vim.o.expandtab = false -- Insert TAB characters instead of spaces
vim.o.softtabstop = 0   -- Disable space/TAB hybrid behavior
vim.o.shiftwidth = 8    -- Number of columns for auto-indent and >>/<< operations
vim.opt.wrap = false    -- disable line wrapping globally
vim.wo.relativenumber = true
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
        vim.opt_local.expandtab = true    -- Use spaces, not tabs
        vim.opt_local.shiftwidth = 2      -- Ormolu uses 2 spaces per indent block
        vim.opt_local.softtabstop = 2     -- Tab key inserts 2 spaces
        vim.opt_local.tabstop = 2         -- If a tab sneaks in, display it as 2 spaces wide
    end,
})
vim.opt.clipboard = "unnamedplus" -- use the system clipboard for yank/paste
vim.diagnostic.config({
	signs = false,
})
