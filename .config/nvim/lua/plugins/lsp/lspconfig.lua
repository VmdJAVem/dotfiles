return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp", },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		-- Lua Language Server
		vim.lsp.config["lua_ls"] = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		}

		-- clangd (C/C++)
		vim.lsp.config["clangd"] = {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders=false",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		}
		vim.lsp.config["haskell-language-server"] = {
			cmd = { "haskell-language-server-wrapper", "--lsp" },
			filetype = { "haskell", "lhaskell" },
			root_markers = { "*.cabal", "stack.yaml", "hie.yaml", "hls.yaml", ".git" },
			settings = {
				haskell = {
					formattingProvider = "ormolu", -- or "fourmolu"
					-- Add other HLS-specific settings here
				}
			}
		}
		vim.lsp.config["tsserver"] = {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
			},
			root_dir = vim.fs.root(0, { "package.json", ".git" }),
			capabilities = capabilities,
			on_attach = function(client)
				-- disable LSP formatting (use prettier instead)
				client.server_capabilities.documentFormattingProvider = false
			end,
		}
		-- HTML
		vim.lsp.config["html"] = {
			cmd = { "vscode-html-language-server", "--stdio" },
			filetypes = { "html" },
		}

		-- CSS
		vim.lsp.config["cssls"] = {
			cmd = { "vscode-css-language-server", "--stdio" },
			filetypes = { "css", "scss", "less" },
		}

		-- Emmet
		vim.lsp.config["emmet_ls"] = {
			cmd = { "emmet-ls", "--stdio" },
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescriptreact",
			},
		}


		-- Enable servers
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("tsserver")
		vim.lsp.enable("html")
		vim.lsp.enable("cssls")
		vim.lsp.enable("emmet_ls")
		vim.lsp.enable("haskell-language-server")
		-- LspAttach: keymaps and formatting
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
					{ desc = 'rename something', silent = true })
				vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action,
					{ desc = "fix diagnostic", silent = true })
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float,
					{ desc = "Open diagnostic", buffer = ev.buf, silent = true })

				-- Navigate diagnostics
				-- Go to next diagnostic (forward)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, opts)

				-- Go to previous diagnostic (backward)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, opts)


				vim.keymap.set("n", "<leader>F", function()
					require("conform").format({ async = true, lsp_fallback = true })
				end, { buffer = ev.buf, desc = 'format buffer', silent = true })

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = ev.buf,
					callback = function()
						require("conform").format({ async = false, lsp_fallback = true })
					end,
				})
			end,
		})
	end,
}
