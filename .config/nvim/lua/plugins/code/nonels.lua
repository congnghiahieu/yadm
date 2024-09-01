return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = {
					-- Lua
					"stylua",

					-- Python
					"isort",
					"black",

					-- JS / TS
					"prettierd",

					-- Go
					"impl",
					"gomodifytags",
					"goimports",
					"gofumpt",

					-- Ruby
					-- "htmlbeautifier",
					-- "rubocop",

					-- Rust

					-- Bash
					"shfmt",
				},
				automatic_installation = false,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Lua
					null_ls.builtins.formatting.stylua,

					--- JS / TS
					null_ls.builtins.formatting.prettierd.with({
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/prettierrc.json"),
						},
					}),

					-- Python
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.black,

					-- Go
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.code_actions.gomodifytags,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.gofumpt,

					-- Ruby
					-- null_ls.builtins.formatting.rubocop,
					-- null_ls.builtins.formatting.htmlbeautifier,

					-- Rust

					-- Bash
					null_ls.builtins.formatting.shfmt,
				},
			})
		end,
	},
}
