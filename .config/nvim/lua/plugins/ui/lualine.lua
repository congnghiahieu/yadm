return {
	"nvim-lualine/lualine.nvim", -- Plugin for status line
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lualine").setup({
			options = {
				-- theme = "dracula",
				theme = "ayu",
			},
			sections = {
				lualine_x = {
					{ require("noice").api.statusline.mode.get, cond = require("noice").api.statusline.mode.has },
				},
			},
		})
	end,
}
