return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	build = "cargo build --release",

	dependencies = {
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		"rafamadriz/friendly-snippets",
	},

	opts = {
		-- Start with a base config (or use the provided opts if any)
		snippets = {
			preset = "luasnip",
		},
		keymap = {
			preset = "super-tab",
			["<C-Tab>"] = { "snippet_forward", "fallback" }
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
		completion = {
			menu = {
				border = "none",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "none",
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "none",
			},
		},
		sources = {
			default = { "lsp", "snippets", "buffer", "path" },
		},
	}

}
