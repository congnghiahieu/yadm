return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- event = "VeryLazy",
		keys = {
			{ "<leader>f", mode = { "n" }, desc = "Telescope" },
		},
		config = function()
			-- Don't preview binaries
			local previewers = require("telescope.previewers")
			local Job = require("plenary.job")
			local new_maker = function(filepath, bufnr, opts)
				filepath = vim.fn.expand(filepath)
				Job:new({
					command = "file",
					args = { "--mime-type", "-b", filepath },
					on_exit = function(j)
						local mime_type = vim.split(j:result()[1], "/")[1]
						if mime_type == "text" then
							previewers.buffer_previewer_maker(filepath, bufnr, opts)
						else -- maybe we want to write something to the buffer here vim.schedule(function() vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" }) end)
						end
					end,
				}):sync()
			end

			-- Telescope mapping
			local actions = require("telescope.actions")
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					mappings = {
						n = {
							["L"] = false,
							["M"] = false,
							["H"] = false,
							["<C-X>"] = false,
							["<C-T>"] = false,
							["<C-V>"] = false,
							-- ["<PageDown>"] = false,
							-- ["<PageUp>"] = false,
							-- ["<C-D>"] = false,
							-- ["<C-U>"] = false,
							["t"] = actions.select_tab,
							["s"] = actions.select_vertical,
							["S"] = actions.select_horizontal,
							-- ["<C-j>"] = actions.preview_scrolling_down,
							-- ["<C-k>"] = actions.preview_scrolling_up,
							-- ["rd"] = actions.results_scrolling_down,
							-- ["ru"] = actions.results_scrolling_up,
							-- ["zz"] = actions.center,
						},
						i = {
							-- Mapping <C-u> to clear prompt
							["<C-u>"] = false,
						},
					},
					-- Don't preview binaries
					buffer_previewer_maker = new_maker,
				},
			})

			-- Telescope builtins mapping - Register whichkey
			local wk = require("which-key")
			wk.add({
				{ "<leader>f", group = "Telescope" },
				{ "<leader>fb", group = "Telescope current buffers" },
				{
					"<leader>fbg",
					"<cmd>Telescope current_buffer_fuzzy_find<CR>",
					desc = "Live fuzzy search inside of the currently open buffer",
				},
				{ "<leader>fbl", "<cmd>Telescope buffers<CR>", desc = "Lists open buffers in current neovim instance" },
				{ "<leader>fc", "<cmd>Telescope colorscheme<CR>", desc = "Show colorscheme" },
				{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in working directory" },
				{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep (search) by live input" },
				{ "<leader>fj", "<cmd>Telescope jumplist<CR>", desc = "Lists Jump List entries" },
				{
					"<leader>fl",
					"<cmd>Telescope loclist<CR>",
					desc = "Lists items from the current window's location list",
				},
				{ "<leader>fm", "<cmd>Telescope marks<CR>", desc = "List vim marks and their value" },
				{ "<leader>fq", "<cmd>Telescope quickfix<CR>", desc = "Lists items in the quickfix list" },
				{
					"<leader>fr",
					"<cmd>Telescope registers<CR>",
					desc = "Lists vim registers, pastes the contents of the register on <cr>",
				},
				{ "<leader>ft", "<cmd>Telescope treesitter<CR>", desc = "Show current file tree" },
				{ "<leader>fv", group = "Version control (Git)" },
				{
					"<leader>fvC",
					"<cmd>Telescope git_bcommits<CR>",
					desc = "List all commits history of current file (buffer)",
				},
				{ "<leader>fvS", "<cmd>Telescope git_stash<CR>", desc = "Git stash" },
				{ "<leader>fvb", "<cmd>Telescope git_branches<CR>", desc = "List all commits history of project" },
				{ "<leader>fvc", "<cmd>Telescope git_commits<CR>", desc = "List all commits history of project" },
				{
					"<leader>fvf",
					"<cmd>Telescope git_files<CR>",
					desc = "Fuzzy search through the output of git ls-files command",
				},
				{ "<leader>fvs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-fzy-native.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
				},
			})
			require("telescope").load_extension("fzy_native")
		end,
	},
}
