return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

					local wk = require("which-key")
					wk.add({
						{ "<leader>v", group = "Version control (Git)" },
						{ "<leader>vh", desc = "Hunk" },
						{ "<leader>vl", "<cmd>LazyGit<CR>", desc = "Open lazygit" },
						{ "<leader>vt", desc = "Toggle show" },
					})

					map("n", "<leader>vhp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>vhP", gs.preview_hunk_inline, "Preview hunk inline")
					map("n", "<leader>vhn", gs.next_hunk, "Next hunk")
					map("n", "<leader>vhN", gs.prev_hunk, "Prev hunk")
					map("n", "<leader>vhs", gs.stage_hunk, "Stage hunk")
					map("n", "<leader>vhS", gs.stage_buffer, "Stage all hunks in current buffer")
					map("n", "<leader>vhr", gs.reset_hunk, "Reset hunk")
					map("n", "<leader>vhR", gs.reset_buffer, "Reset the lines of all hunks in the buffer")
					map("n", "<leader>vhu", gs.undo_stage_hunk, "Undo the last call of stage_hunk")

					map("n", "<leader>vtd", gs.toggle_deleted, "Toggle gs config show_deleted")
					map("n", "<leader>vtb", gs.toggle_current_line_blame, "Toggle gs config current_line_blame")
					map("n", "<leader>vtw", gs.toggle_word_diff, "Toggle gs config word_diff")
					map("n", "<leader>vtl", gs.toggle_linehl, "Toggle gs config linehl")
					map("n", "<leader>vtn", gs.toggle_numhl, "Toggle gs config numhl")
					map("n", "<leader>vts", gs.toggle_signs, "Toggle gs config signbooleancolumn")

					map("n", "<leader>vb", function()
						gs.blame_line({ full = true })
					end, "Blame Line")

					map("n", "<leader>vd", gs.diffthis, "Diff This")
					map("n", "<leader>vD", function()
						gs.diffthis("~")
					end, "Diff this ~")
				end,
			})
		end,
	},
}
