return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme                = {
				normal = {
					a = { fg = "#24273a", bg = "#c6a0f6", gui = "bold" },
					b = { fg = "#cad3f5", bg = "#363a4f" },
					c = { fg = "#cad3f5", bg = "#24273a" },
				},
				insert = {
					a = { fg = "#24273a", bg = "#8aadf4", gui = "bold" },
					b = { fg = "#cad3f5", bg = "#363a4f" },
					c = { fg = "#cad3f5", bg = "#24273a" },
				},
				visual = {
					a = { fg = "#24273a", bg = "#c6a0f6", gui = "bold" },
					b = { fg = "#cad3f5", bg = "#363a4f" },
					c = { fg = "#cad3f5", bg = "#24273a" },
				},
				replace = {
					a = { fg = "#24273a", bg = "#ed8796", gui = "bold" },
					b = { fg = "#cad3f5", bg = "#363a4f" },
					c = { fg = "#cad3f5", bg = "#24273a" },
				},
				command = {
					a = { fg = "#24273a", bg = "#f5a97f", gui = "bold" },
					b = { fg = "#cad3f5", bg = "#363a4f" },
					c = { fg = "#cad3f5", bg = "#24273a" },
				},
				inactive = {
					a = { fg = "#cad3f5", bg = "#24273a", gui = "bold" },
					b = { fg = "#cad3f5", bg = "#24273a" },
					c = { fg = "#cad3f5", bg = "#24273a" },
				},
			},
			section_separators   = { left = '', right = ' ' },
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
			lualine_y = { "diagnostics" },
			lualine_z = { "hostname" },
		},
	},
}