return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	opts = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			enable_check_bracket_line = false,
		})

		-- remove the skip-over behavior for ')'
		npairs.remove_rule(")")
	end,
}
