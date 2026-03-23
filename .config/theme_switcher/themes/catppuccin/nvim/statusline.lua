return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			-- Inline custom Catppuccin Mocha theme
			theme                = {
				normal = {
					a = { fg = "#1e1e2e", bg = "#cba6f7", gui = "bold" },
					b = { fg = "#cdd6f4", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#1e1e2e" },
				},
				insert = {
					a = { fg = "#1e1e2e", bg = "#89b4fa", gui = "bold" },
					b = { fg = "#cdd6f4", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#1e1e2e" },
				},
				visual = {
					a = { fg = "#1e1e2e", bg = "#cba6f7", gui = "bold" },
					b = { fg = "#cdd6f4", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#1e1e2e" },
				},
				replace = {
					a = { fg = "#1e1e2e", bg = "#f38ba8", gui = "bold" },
					b = { fg = "#cdd6f4", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#1e1e2e" },
				},
				command = {
					a = { fg = "#1e1e2e", bg = "#fab387", gui = "bold" },
					b = { fg = "#cdd6f4", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#1e1e2e" },
				},
				inactive = {
					a = { fg = "#cdd6f4", bg = "#1e1e2e", gui = "bold" },
					b = { fg = "#cdd6f4", bg = "#1e1e2e" },
					c = { fg = "#cdd6f4", bg = "#1e1e2e" },
				},
			},
			section_separators   = { left = '', right = '' },
			component_separators = { left = '', right = '' },
		},
		sections = {
			lualine_a = {
				{ function() return '  ' end, separator = '', padding = 0 },
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
