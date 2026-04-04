-- Keymaps are automatically loaded on the VeryLazy event
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
	local word = vim.fn.expand("<cword>") -- word under cursor
	local suggestions = vim.fn.spellsuggest(word)
	if #suggestions == 0 then
		print("No spelling suggestions")
		return
	end
	vim.ui.select(suggestions, {
		prompt = "Spelling suggestions:",
	}, function(choice)
		if choice then
			-- replace the word under cursor with the chosen one
			vim.cmd("normal! ciw" .. choice)
		end
	end)
end, { desc = "[P] Corrector (pick)" })

vim.keymap.set('n', '<leader>s', ':set spell!<CR>', { desc = 'Toggle spell' })

vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "bd", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>e", ":Neotree<CR>", { desc = "File explorer" })
