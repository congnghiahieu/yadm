return {
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 500,
			max_height = function()
				return math.floor(vim.o.lines * 1)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.5)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		config = function()
			vim.notify = require("notify")
		end,
	},
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	config = function()
	-- 		local fidget = require("fidget")
	-- 		fidget.setup()
	-- 	end,
	-- },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "change",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "yanked",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "more",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "less",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "fewer",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "No lines in buffer",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "No information available",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							kind = "search_count",
						},
						opts = { skip = true },
					},
				},
			})
			require("telescope").load_extension("noice")
		end,
	},
}
