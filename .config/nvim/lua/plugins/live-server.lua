return {
	"hyperstown/nvim-live-server",
	cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
	lazy = false,
	opts = {
		host = "127.0.0.1", -- optional, default 0.0.0.0
		port = 5550,  -- optional, default 8080
		bind_attempts = 3, -- optional, default 2
		ignore_files = { "*.env" }, -- optional, default {}
		ignore_dotfiles = true, -- optional default true
		open_browser = true, -- optional, default true
	},
}
