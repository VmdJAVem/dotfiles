vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")

vim.opt.fillchars:append({ eob = " " })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		if vim.fn.isdirectory(data.file) == 1 then
			require("neo-tree.command").execute({ dir = data.file })
		end
	end,
})

vim.treesitter.language.register("markdown", "vimwiki")

require("config.keymaps")
require("config.options")
require("config.theme")
