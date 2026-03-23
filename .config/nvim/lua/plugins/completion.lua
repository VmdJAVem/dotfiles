return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	build = "cargo build --release",

	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},

	opts = {
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
				winblend = 40,
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "none",
					winblend = 30,
					winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder"
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
	},
}
