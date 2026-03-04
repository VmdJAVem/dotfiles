-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>mb", function()
	vim.opt.spelllang = "en,es"
	vim.cmd("echo 'Español y Ingles'")
end, { desc = "[P] Español y Ingles" })
vim.keymap.set("n", "<leader>me", function()
	vim.opt.spelllang = "en"
	vim.cmd("echo 'Ingles'")
end, { desc = "[P]Ingles" })
vim.keymap.set("n", "<leader>ms", function()
	vim.opt.spelllang = "es"
	vim.cmd("echo 'Español'")
end, { desc = "[P] Español" })
vim.keymap.set("n", "<leader>mc", function()
	vim.cmd("normal! 1z=")
end, { desc = "[P]Corrector" })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qS", function()
	require("persistence").select()
end)
