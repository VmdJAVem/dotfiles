return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			-- theme                = custom_gruvbox_hard,
			section_separators   = { left = ' ', right = ' ' },
			component_separators = { left = ' ', right = ' ' },
		},

		sections = {
			lualine_a = {
				{ function() return " " end, separator = "", padding = 0 },
				"mode",
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
	}
}
