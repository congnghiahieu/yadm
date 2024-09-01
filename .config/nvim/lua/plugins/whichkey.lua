return {
	{
		"folke/which-key.nvim",
		opts = {},
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000

			local wk = require("which-key")

			wk.add({
				{ "<space>f", group = "Misc" },
				{ "<space>fC", "<cmd>Copilot disable<CR>", desc = "Disable copilot" },
				{ "<space>fc", "<cmd>Copilot enable<CR>", desc = "Enable copilot" },
				{ "<space>fy", "<cmd>%y<CR>", desc = "Yank file content" },
				{ "<space>fd", "<cmd>%d<CR>", desc = "Delete file content" },
				{ "<space>fv", "ggVG", desc = "Visual file content" },
				{ "<space>fm", "<cmd>delmarks A-Z0-9<CR>", desc = "Clear marks A-Z0-9" },
				{
					"<space>fn",
					function()
						require("notify").dismiss({ silent = true, pending = true })
					end,
					desc = "Dismiss all Notifications",
				},
				{ "<space>fs", "<cmd>nohlsearch<cr>", desc = "No search highlight" },
				{ "<space>fw", "<cmd>set wrap<CR>", desc = "Wrap line" },
				{ "<space>fh", "<cmd>InlayHintsToggle<CR>", desc = "Inlay hints toggle" },
				{ "<space>fl", "<cmd>LspRestart<CR>", desc = "Restart LSP" },
				{ "<space>fi", "^y$^", desc = "Yank current line" },
			})
		end,
	},
}
