vim.g.mapleader = ' '
require("config.lazy")

vim.opt.fillchars:append({ eob = " " })

vim.treesitter.language.register("markdown", "vimwiki")
vim.diagnostic.config({
	virtual_text = true,
})
require("config.keymaps")
require("config.options")
require("config.theme")
vim.opt.runtimepath:append("~/.local/share/nvim/site")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local cmdGrp = vim.api.nvim_create_augroup("cmdline_height", { clear = true })

local function set_cmdheight(val)
	if vim.opt.cmdheight:get() ~= val then
		vim.opt.cmdheight = val
		vim.cmd.redrawstatus()
	end
end

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = cmdGrp,
	callback = function()
		if vim.fn.getcmdtype() == ":" then
			set_cmdheight(1)
		end
	end,
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
	group = cmdGrp,
	callback = function()
		if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "" then
			set_cmdheight(0)
		end
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = cmdGrp,
	callback = function()
		set_cmdheight(0)
	end,
})
vim.api.nvim_create_autocmd("VimEnter", {
	group = cmdGrp, -- your existing group
	callback = function()
		set_cmdheight(0)
	end,
})
