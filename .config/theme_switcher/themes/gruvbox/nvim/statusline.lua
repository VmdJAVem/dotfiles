return {
	"nvim-lualine/lualine.nvim",
	opts = function()
		local colors = {
			bg = "#1d2021",
			fg = "#ebdbb2",
			yellow = "#d79921",
			blue = "#458588",
			green = "#98971a",
			red = "#cc241d",
			purple = "#b16286",
			aqua = "#689d6a",
			gray = "#7c6f64",
		}

		local custom_gruvbox_hard = {
			normal = {
				a = { bg = colors.gray, fg = colors.fg },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg },
				b = { bg = colors.bg, fg = colors.green },
			},
			visual = {
				a = { bg = colors.purple, fg = colors.bg },
				b = { bg = colors.bg, fg = colors.purple },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg },
				b = { bg = colors.bg, fg = colors.red },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg },
				b = { bg = colors.bg, fg = colors.yellow },
			},
			inactive = {
				a = { bg = colors.bg, fg = colors.gray },
				b = { bg = colors.bg, fg = colors.gray },
				c = { bg = colors.bg, fg = colors.gray },
			},
		}

		return {
			options = {
				theme                = custom_gruvbox_hard,
				section_separators   = { left = '', right = '' },
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
	end,
}
