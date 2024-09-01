return {
	{
		"akinsho/bufferline.nvim", -- tab bar plugins
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "ordinal",
					separator_style = "slope",
					diganostics = "nvim_lsp",
				},
				highlights = {
					buffer_selected = {
						bold = true,
						italic = true,
					},
					indicator_selected = {
						fg = "white",
						bg = "orange",
					},
				},
			})

			local wk = require("which-key")
			wk.add({
				{ "gb", group = "Go to buffers" },
				{ "gb1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
				{ "gb2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
				{ "gb3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
				{ "gb4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
				{ "gb5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
				{ "gb6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
				{ "gb7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
				{ "gb8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
				{ "gb9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
				{ "gbN", "<Cmd>BufferLineCyclePrev<CR>", desc = "Go to prev buffer" },
				{ "gbP", "<Cmd>BufferLinePickClose<CR>", desc = "Pick close a buffer" },
				{ "gbc", group = "Close buffers" },
				{ "gbcc", "<Cmd>bd<CR>", desc = "Close current buffer" },
				{ "gbcl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close all buffers on the left" },
				{ "gbco", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all other buffers" },
				{ "gbcr", "<Cmd>BufferLineCloseRight<CR>", desc = "Close all buffers on the right" },
				{ "gbn", "<Cmd>BufferLineCycleNext<CR>", desc = "Go to next buffer" },
				{ "gbp", "<Cmd>BufferLinePick<CR>", desc = "Pick open a buffer" },
			})
		end,
	},
}