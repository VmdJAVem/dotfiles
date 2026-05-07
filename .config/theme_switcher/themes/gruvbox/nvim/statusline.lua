return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = {
				normal = {
					a = { fg = "#282828", bg = "#98971a", gui = "bold" },
					b = { fg = "#ebdbb2", bg = "#3c3836" },
					c = { fg = "#ebdbb2", bg = "#282828" },
				},
				insert = {
					a = { fg = "#282828", bg = "#458588", gui = "bold" },
					b = { fg = "#ebdbb2", bg = "#3c3836" },
					c = { fg = "#ebdbb2", bg = "#282828" },
				},
				visual = {
					a = { fg = "#282828", bg = "#b16286", gui = "bold" },
					b = { fg = "#ebdbb2", bg = "#3c3836" },
					c = { fg = "#ebdbb2", bg = "#282828" },
				},
				replace = {
					a = { fg = "#282828", bg = "#cc241d", gui = "bold" },
					b = { fg = "#ebdbb2", bg = "#3c3836" },
					c = { fg = "#ebdbb2", bg = "#282828" },
				},
				command = {
					a = { fg = "#282828", bg = "#d79921", gui = "bold" },
					b = { fg = "#ebdbb2", bg = "#3c3836" },
					c = { fg = "#ebdbb2", bg = "#282828" },
				},
				inactive = {
					a = { fg = "#a89984", bg = "#282828", gui = "bold" },
					b = { fg = "#a89984", bg = "#282828" },
					c = { fg = "#a89984", bg = "#282828" },
				},
			},

			section_separators = { left = '', right = ' ' },
			component_separators = { left = ' ', right = ' ' },
		},

		sections = {
			lualine_a = {
				{ function() return ' ' end, separator = '', padding = 0 },
				'mode'
			},

			lualine_b = {
				"filename",
				"branch",
				"diff",
			},

			lualine_c = {
				{ "buffers", mode = 1, hide_filename_extension = true },
			},

			lualine_x = {},

			lualine_y = {
				"diagnostics"
			},

			lualine_z = {
				"hostname"
			},
		},
	},
}
