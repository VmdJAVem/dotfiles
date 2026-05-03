return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},

	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- lua_ls
		vim.lsp.config.lua_ls = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		-- clangd
		vim.lsp.config.clangd = {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders=false",
			},
			filetypes = { "c", "cpp" },
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		}

		-- haskell-language-server
		vim.lsp.config.hls = {
			cmd = { "haskell-language-server-wrapper", "--lsp" },
			filetypes = { "haskell", "lhaskell" },
			root_markers = {
				"*.cabal",
				"stack.yaml",
				"hie.yaml",
				"hls.yaml",
				".git",
			},
			settings = {
				haskell = {
					formattingProvider = "ormolu",
				},
			},
		}

		-- enable servers
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("hls")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),

			callback = function(ev)
				local opts = {
					buffer = ev.buf,
					silent = true,
				}

				-- navigation
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

				-- actions
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {
					buffer = ev.buf,
					desc = "rename symbol",
					silent = true,
				})

				vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, {
					buffer = ev.buf,
					desc = "code action",
					silent = true,
				})

				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
					buffer = ev.buf,
					desc = "open diagnostic",
					silent = true,
				})

				-- diagnostics navigation
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, opts)

				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, opts)

				-- manual format
				vim.keymap.set("n", "<leader>F", function()
					vim.lsp.buf.format({
						async = true,
					})
				end, {
					buffer = ev.buf,
					desc = "format buffer",
					silent = true,
				})

				-- format on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = ev.buf,
					callback = function()
						vim.lsp.buf.format({
							async = false,
						})
					end,
				})
			end,
		})
	end,
}
