return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			{
				"rust-lang/rust.vim",
				ft = "rust",
				init = function()
					vim.cmd("let g:rustfmt_autosave = 1")
				end,
			},
			{
				"MysticalDevil/inlay-hints.nvim",
				event = "LspAttach",
				dependencies = { "neovim/nvim-lspconfig" },
				config = function()
					require("inlay-hints").setup()
				end,
			},
			-- { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
			-- { "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Lua
					"lua_ls",

					-- Python
					"pyright",

					-- JS / TS
					"ts_ls",
					-- "tailwindcss",
					-- "cssls",
					-- "prismals",
					-- "graphql",

					-- Go
					"gopls",

					-- Ruby
					-- "solargraph",

					-- Rust
					"rust_analyzer",

					-- Bash, Docker, JSON, YAML, XML, TOML
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"jsonls",
					"yamlls",
					"lemminx",
					"taplo",
				},
				automatic_installation = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local wk = require("which-key")

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						hint = {
							enable = true, -- necessary
						},
						-- workspace = { checkThirdParty = false },
						-- telemetry = { enable = false },
						-- completion = {
						-- 	callSnippet = "Replace",
						-- },
						-- -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { "missing-fields" } },
					},
				},
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							typeCheckingMode = "standard",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- JS / TS
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})
			-- lspconfig.graphql.setup({capabilities = capabilities})
			-- lspconfig.prismals.setup({ capabilities = capabilities })
			-- lspconfig.cssls.setup({ capabilities = capabilities })
			-- lspconfig.tailwindcss.setup({
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		tailwindCSS = {
			-- 			experimental = {
			-- 				classRegex = {
			-- 					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
			-- 					{ "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "tw\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "cva\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "cx\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "cn\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "tw\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })

			-- Go
			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			})

			-- Ruby
			-- lspconfig.solargraph.setup({
			-- 	capabilities = capabilities,
			-- 	root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
			-- 	settings = {
			-- 		solargraph = {
			-- 			autoformat = true,
			-- 			completion = true,
			-- 			diagnostic = true,
			-- 			folding = true,
			-- 			references = true,
			-- 			rename = true,
			-- 			symbols = true,
			-- 		},
			-- 	},
			-- })

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = function() end,
				filetypes = { "rust" },
				root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = true,
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
						inlayHints = {
							chainingHints = true,
							typeHints = true,
							parameterHints = true,
							otherHints = true,
						},
					},
				},
			})

			-- Bash, Docker, JSON, YAML, XML, TOML
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.dockerls.setup({ capabilities = capabilities })
			lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.yamlls.setup({ capabilities = capabilities })
			lspconfig.lemminx.setup({ capabilities = capabilities })
			lspconfig.taplo.setup({
				capabilities = capabilities,
			})

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<space>gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "<space>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<space>gt", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<space>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>gh", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<space>gs", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>ar", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<space>af", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set({ "n", "v" }, "<space>aa", vim.lsp.buf.code_action, opts)
				end,
			})

			wk.add({
				{ "<space>a", group = "Action" },
				{ "<space>aa", desc = "Code action" },
				{ "<space>af", desc = "Format" },
				{ "<space>ar", desc = "Rename" },
				{ "<space>g", group = "Go to" },
				{ "<space>gD", desc = "Go to declaration" },
				{ "<space>gd", desc = "Go to definition" },
				{ "<space>gh", desc = "Go to hover information" },
				{ "<space>gi", desc = "Go to implementation" },
				{ "<space>gr", desc = "Go to references" },
				{ "<space>gs", desc = "Go to signature help" },
				{ "<space>gt", desc = "Go to type definition" },
				{ "<space>w", group = "Workspace" },
				{ "<space>wa", desc = "Add folder to workspace" },
				{ "<space>wl", desc = "List folder in workspace" },
				{ "<space>wr", desc = "Remove folder out of workspace" },
			})
		end,
	},
}
