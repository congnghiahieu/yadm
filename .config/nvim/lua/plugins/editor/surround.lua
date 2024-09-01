return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = function()
		-- The three "core" operations of add/delete/change can be done with the keymaps
		-- ys{motion}{char},
		-- ds{char},
		-- and cs{char}{replace}

		require("nvim-surround").setup({
			keymaps = {
				-- Any keymaps not end with "_line", will append 2 new delimeter (start and end) inline
				-- Any keymaps end with "_line", will append 2 new delimeter (start and end) in new line (first and last line).
				-- All the wrapped text will be put in the middle
				insert = "<C-s>i",
				insert_line = "<C-s>I",
				normal = "<space>sa",
				normal_cur = "<space>sA",
				normal_line = "<space>sl",
				normal_cur_line = "<space>sL",
				visual = "<space>sa",
				visual_line = "<space>sA",
				delete = "<space>sd",
				change = "<space>sc",
				change_line = "<space>sC",
			},
		})

		local wk = require("which-key")
		wk.add({
			{ "<space>s", group = "Surrounding" },
			{ "<space>sA", desc = "Add, select full current line, surround inline" },
			{ "<space>sC", desc = "Change {char}{replace}, surround new line" },
			{ "<space>sL", desc = "Add, select full current line, surround new line" },
			{ "<space>sa", desc = "Add, select by motion, surround inline" },
			{ "<space>sc", desc = "Change {char}{replace}, surround inline" },
			{ "<space>sd", desc = "Delete {char}" },
			{ "<space>sl", desc = "Add, select by motion, surround new line" },
		})
		wk.add({
			mode = { "v" },
			{ "<space>s", group = "Surrounding" },
			{ "<space>sA", desc = "Add, select by visual mode, surround new line" },
			{ "<space>sa", desc = "Add, select by visual mode, surround inline" },
		})
	end,
}
