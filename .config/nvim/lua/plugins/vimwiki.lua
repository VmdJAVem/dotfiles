return {
	"vimwiki/vimwiki",
	init = function()
		vim.g.vimwiki_list = {
			{
				path = "~/.vimwiki/",
				syntax = "markdown", -- fixed
				ext = ".md", -- using .md files (Markdown)
			},
		}
		vim.g.vimwiki_global_ext = 0 -- optional: don't treat all .md as wikis
	end,
}
