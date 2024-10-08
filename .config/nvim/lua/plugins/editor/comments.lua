return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("Comment").setup({
				---Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = "<space>cl",
					---Block-comment toggle keymap
					block = "<space>cb",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = "<space>cl",
					---Block-comment keymap
					block = "<space>cb",
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					-- above = "gcO",
					---Add comment on the line below
					-- below = "gco",
					---Add comment at the end of line
					-- eol = "gcA",
				},
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = false,
				},
				---Function to call before (un)comment
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				---Function to call after (un)comment
				post_hook = nil,
			})

			-- Register whickey
			local wk = require("which-key")
			wk.add({
				{ "<space>c", group = "Comment" },
				{ "<space>cb", desc = "Comment block" },
				{ "<space>cl", desc = "Comment line" },
			})
		end,
	},
}
