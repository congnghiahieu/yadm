return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			local wk = require("which-key")
			wk.add({
				{ "<leader>h", group = "Harpoon" },
			})

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():append()
			end, { desc = "Append to harpoon list" })
			vim.keymap.set("n", "<leader>ht", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle harpoon menu" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end, { desc = "Go to next buffer stored in Harpoon" })
			vim.keymap.set("n", "<leader>hN", function()
				harpoon:list():prev()
			end, { desc = "Go to previous buffer stored in Harpoon" })

			-- Basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<leader>fh", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Harpoon telescope" })
		end,
	},
	-- 	{
	-- 		"chentoast/marks.nvim",
	-- 		config = function()
	-- 			require("which-key").register({
	-- 				["<leader>m"] = {
	-- 					name = "Marks",
	-- 					c = {
	-- 						"<cmd>delsmarks A-Z0-9<CR>",
	-- 						"Clear marks A-Z0-9",
	-- 					},
	-- 				},
	-- 			})
	-- 			require("marks").setup({
	-- 				-- whether to map keybinds or not. default true
	-- 				-- default_mappings = true,
	-- 				mappings = {
	-- 					set_next = "<leader>ms",
	-- 					next = "<leader>mn",
	-- 					prev = "<leader>mN",
	-- 					delete = "<leader>md",
	-- 					delete_buf = "<leader>mD",
	-- 				},
	-- 				-- which builtin marks to show. default {}
	-- 				-- builtin_marks = { "'", '"', "[", "]", "^", "." },
	-- 				builtin_marks = {},
	-- 				-- whether movements cycle back to the beginning/end of buffer. default true
	-- 				cyclic = true,
	-- 				-- whether the shada file is updated after modifying uppercase marks. default false
	-- 				force_write_shada = true,
	-- 				-- how often (in ms) to redraw signs/recompute mark positions.
	-- 				-- higher values will have better performance but may cause visual lag,
	-- 				-- while lower values may cause performance penalties. default 150.
	-- 				refresh_interval = 1000,
	-- 				-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- 				-- marks, and bookmarks.
	-- 				-- can be either a table with all/none of the keys, or a single number, in which case
	-- 				-- the priority applies to all marks.
	-- 				-- default 10.
	-- 				sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	-- 				-- disables mark tracking for specific filetypes. default {}
	-- 				excluded_filetypes = {},
	-- 				-- disables mark tracking for specific buftypes. default {}
	-- 				excluded_buftypes = {},
	-- 				-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- 				-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- 				-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- 				-- default virt_text is "".
	-- 				bookmark_0 = {
	-- 					sign = "⚑",
	-- 					-- virt_text = "hello world",
	-- 					-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
	-- 					-- defaults to false.
	-- 					-- annotate = false,
	-- 				},
	-- 			})
	-- 		end,
	-- 	},
}
