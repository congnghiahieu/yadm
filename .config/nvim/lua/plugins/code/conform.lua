return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Lua
				lua = { "stylua" },

				-- Python
				python = { "isort", "black" },

				-- JS / TS
				css = { { "prettierd", "prettier" } },
				graphql = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				jsx = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				tsx = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				vue = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },

				-- Go
				go = {
					"goimports",
					"gofumpt",
				},

				-- Ruby
				-- ruby = { "rubocop" },
				-- eruby = { "htmlbeautifier" },

				-- Rust

				-- Bash
				sh = {
					"shfmt",
				},
			},
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			-- If this is set, Conform will run the formatter asynchronously after save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_after_save = {
				lsp_format = "fallback",
			},
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,
			-- Conform will notify you when a formatter errors
			notify_on_error = true,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
