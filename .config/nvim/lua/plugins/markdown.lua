return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons", -- clean, modern icon provider
	},
	ft = { "markdown", "vimwiki" },
	opts = {
		-- Credits: https://tduyng.com/blog/neovim-markdown-notes/
		icons = {
			provider = "mini.icons",
		},
		latex = { enabled = true },
		markdown_inline = { enabled = true },
		html = { enabled = true },

		heading = {
			enabled = true,
			render_modes = true,
			sign = true,
			icons = { " ", " ", " ", " ", " ", " " }, -- hides '#' characters
			position = "overlay",
			signs = { " " },
			width = "full",
			left_margin = 0,
			left_pad = 0,
			right_pad = 0,
			min_width = 0,
			border = false,
			backgrounds = {
				"RenderMarkdownH1Bg", "RenderMarkdownH2Bg", "RenderMarkdownH3Bg",
				"RenderMarkdownH4Bg", "RenderMarkdownH5Bg", "RenderMarkdownH6Bg",
			},
			foregrounds = {
				"RenderMarkdownH1", "RenderMarkdownH2", "RenderMarkdownH3",
				"RenderMarkdownH4", "RenderMarkdownH5", "RenderMarkdownH6",
			},
		},
		code = {
			enabled = true,
			render_modes = true,
			sign = false,
			style = "none",
			position = "left",
			language_pad = 0,
			language_name = true,
			width = "full",
			left_margin = 0,
			left_pad = 0,
			right_pad = 0,
			min_width = 0,
			border = "thin",
			above = "▄",
			below = "▀",
			highlight_language = "Normal",
			highlight = 'Normal',
			highlight_border = 'Normal',
		},

		checkbox = {
			enabled = true,
			render_modes = true,
			position = "inline",
			unchecked = { icon = " ", highlight = "RenderMarkdownUnchecked" },
			checked = { icon = " ", highlight = "RenderMarkdownChecked" },
			custom = {
				todo = { raw = "[-]", rendered = " Todo", highlight = "RenderMarkdownTodo" },
			},
		},
		pipe_table = {
			enabled = true,
			render_modes = true,
			preset = "none",
			style = "full",
			cell = "padded",
			padding = 1,
			border = {
				"┌", "┬", "┐", "├", "┼", "┤", "└", "┴", "┘", "│", "─",
			},
		},
		callout = {
			note = { raw = "[!NOTE]", rendered = " Note", highlight = "RenderMarkdownInfo" },
			tip = { raw = "[!TIP]", rendered = " Tip", highlight = "RenderMarkdownSuccess" },
			warning = { raw = "[!WARNING]", rendered = " Warning", highlight = "RenderMarkdownWarn" },
			caution = { raw = "[!CAUTION]", rendered = " Caution", highlight = "RenderMarkdownError" },
			todo = { raw = "[!TODO]", rendered = " Todo", highlight = "RenderMarkdownInfo" },
		},
	},
	keys = {
		{ "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown rendering" },
	},
}
