return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	-- event = "VeryLazy",
	-- keys = {
	-- 	{ "<leader>n", mode = { "n" }, desc = "Navigation sidebar" },
	-- },
	config = function()
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			source_selector = {
				winbar = true, -- toggle to show selector on winbar
				statusline = false, -- toggle to show selector on statusline
			},
			window = {
				position = "left",
				width = 30,
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},
		})

		local wk = require("which-key")
		wk.add({
			{ "<leader>n", group = "Navigation sidebar" },
			{ "<leader>nb", "<cmd>Neotree position=bottom<CR>", desc = "Open navigation sidebar at bottom" },
			{ "<leader>nc", "<cmd>Neotree close<CR>", desc = "Close navigation sidebar" },
			{ "<leader>nf", "<cmd>Neotree float<CR>", desc = "Open float navigation sidebar" },
			{ "<leader>nl", "<cmd>Neotree position=left<CR>", desc = "Open navigation sidebar on left" },
			{ "<leader>nr", "<cmd>Neotree position=right<CR>", desc = "Open navigation sidebar on right" },
			{ "<leader>nt", "<cmd>Neotree position=top<CR>", desc = "Open navigation sidebar on top" },
		})
	end,
}
