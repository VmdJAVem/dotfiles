vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local groups = {
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
	end,
})

vim.cmd.colorscheme("gruvbox")
vim.opt.fillchars:append({ eob = " " })
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		if vim.fn.isdirectory(data.file) == 1 then
			require("neo-tree.command").execute({ dir = data.file })
		end
	end,
})
vim.treesitter.language.register('markdown', 'vimwiki')
require("config.keymaps")
require("config.options")
vim.g.haskell_tools = {
	tools = {
		log = {
			level = vim.log.levels.DEBUG,
		},
	},
}
