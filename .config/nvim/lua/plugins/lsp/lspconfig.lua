return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
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
		vim.lsp.config["tsserver"] = {
			cmd = { 'typescript-language-server', '--stdio' },
			filetypes = { 'typescript', 'javascript', 'typescriptreact' },
			root_dir = vim.fs.root(0, { 'package.json', '.git' }),
			on_attach = on_attach,
			capabilities = capabilities
		}


		-- Enable servers
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("tsserver")

		-- LspAttach: keymaps and formatting
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'rename something' })
				vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action,
					{ desc = "fix diagnostic" })
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float,
					{ desc = "Open diagnostic", buffer = ev.buf })

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
					vim.lsp.buf.format({ async = true })
				end, { buffer = ev.buf, desc = "format buffer" })

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = ev.buf,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end,
		})
	end,
}
