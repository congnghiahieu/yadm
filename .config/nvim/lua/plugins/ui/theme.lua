return {
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("onedark")
	-- 	end,
	-- },
	{
		"Shatur/neovim-ayu",
		priority = 1000,
		config = function()
			require("ayu").colorscheme({
				mirage = true,
				terminal = false,
			})
			vim.cmd.colorscheme("ayu-mirage")
			-- vim.cmd.colorscheme("ayu-dark")
		end,
	},
}
