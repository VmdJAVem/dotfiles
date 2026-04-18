return {
	'nvim-mini/mini.nvim',
	version = false,
	config = function()
		local gen = require('mini.clue').gen_clues

		local clues = {}
		vim.list_extend(clues, gen.g())
		vim.list_extend(clues, gen.z())
		vim.list_extend(clues, gen.windows())
		vim.list_extend(clues, gen.marks())
		vim.list_extend(clues, gen.registers({ show_contents = true })) -- optional: show register contents
		vim.list_extend(clues, gen.builtin_completion())
		vim.list_extend(clues, gen.square_brackets())

		require('mini.clue').setup({
			triggers = {
				{ mode = 'n', keys = '<leader>' },
				{ mode = 'x', keys = '<leader>' },

				{ mode = 'i', keys = '<C-x>' },

				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },

				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },

				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },

				{ mode = 'n', keys = '<C-w>' },

				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },

				{ mode = 'n', keys = '[' },
				{ mode = 'n', keys = ']' },
			},

			clues = clues,

			window = {
				border = 'single',
				delay = 200,
			},

			options = {
				use_debug = false,
			},
		})
		require('mini.pairs').setup()
		require('mini.files').setup({

			mappings = {
				close       = 'q',
				go_in       = 'l',
				go_in_plus  = 'L',
				go_out      = 'h',
				go_out_plus = 'H',
				mark_goto   = "'",
				mark_set    = 'm',
				reset       = '<BS>',
				reveal_cwd  = '@',
				show_help   = 'g?',
				synchronize = '=',
				trim_left   = '<',
				trim_right  = '>',
			},
			windows = {
				-- Maximum number of windows to show side by side
				max_number = 3,
				-- Whether to show preview of file/directory under cursor
				preview = true,
				-- Width of focused window
				width_focus = 50,
				-- Width of non-focused window
				width_nofocus = 15,
				-- Width of preview window
				width_preview = 50,
			},
		})
		local hipatterns = require('mini.hipatterns')
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
				hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
				todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
				note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end
}
