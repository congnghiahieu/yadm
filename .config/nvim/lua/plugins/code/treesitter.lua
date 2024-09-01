return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"angular",
					"asm",
					"astro",
					"bash",
					"bibtex",
					"blueprint",
					"c",
					"c_sharp",
					"clojure",
					"cmake",
					"cpp",
					"css",
					"csv",
					"cuda",
					"dart",
					"diff",
					"dockerfile",
					"doxygen",
					"elixir",
					"erlang",
					"fish",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"graphql",
					"groovy",
					"haskell",
					"html",
					"htmldjango",
					"java",
					"javascript",
					"jq",
					"jsdoc",
					"json",
					"json5",
					"jsonc",
					"julia",
					"kotlin",
					-- "latex",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"matlab",
					"nim",
					"nim_format_string",
					"ninja",
					"nix",
					"ocaml",
					"ocaml_interface",
					"pascal",
					"passwd",
					"pem",
					"perl",
					"php",
					"php_only",
					"phpdoc",
					"prisma",
					"properties",
					"proto",
					"pug",
					"puppet",
					"pymanifest",
					"python",
					"regex",
					"requirements",
					"robot",
					"ron",
					"rst",
					"ruby",
					"rust",
					"scala",
					"scss",
					"solidity",
					"sql",
					"ssh_config",
					"svelte",
					-- "swift",
					"terraform",
					"tmux",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
				},
				auto_install = false,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 1, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			local wk = require("which-key")
			wk.add({
				{ "<space>S", desc = "Swap textobject" },
			})

			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
							["ii"] = {
								query = "@conditional.inner",
								desc = "Select inner part of a conditional region",
							},
							["ai"] = {
								query = "@conditional.outer",
								desc = "Select outer part of a conditional region",
							},
							["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
							["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
						},

						-- You can choose the select mode (default is charwise 'v')
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@class.inner"] = "V",
							["@class.outer"] = "V",
							["@conditional.inner"] = "V",
							["@conditional.outer"] = "V",
							["@function.inner"] = "V",
							["@function.outer"] = "V",
							["@loop.inner"] = "V",
							["@loop.outer"] = "V",
							["@parameter.inner"] = "v",
							["@parameter.outer"] = "v",
						},

						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_next = {
							["<space>Sc"] = { query = "@class.inner", desc = "Swap with next class" },
							["<space>Si"] = { query = "@conditional.inner", desc = "Swap with next conditional" },
							["<space>Sf"] = { query = "@function.inner", desc = "Swap with next function" },
							["<space>Sl"] = { query = "@loop.inner", desc = "Swap with next loop" },
							["<space>Sa"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
						},
						swap_previous = {
							["<space>SC"] = { query = "@class.inner", desc = "Swap with previous class" },
							["<space>SI"] = { query = "@conditional.inner", desc = "Swap with previous conditional" },
							["<space>SF"] = { query = "@function.inner", desc = "Swap with previous function" },
							["<space>SL"] = { query = "@loop.inner", desc = "Swap with previous loop" },
							["<space>SA"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
						},
					},
					move = {
						enable = true,
						-- whether to set jumps in the jumplist
						set_jumps = true,

						goto_next_start = {
							["]c"] = { query = "@class.outer", desc = "Next class start" },
							["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
							["]f"] = { query = "@function.outer", desc = "Next function start" },
							["]l"] = { query = "@loop.outer", desc = "Next loop start" },
							["]a"] = { query = "@parameter.outer", desc = "Next parameter start" },
						},
						goto_next_end = {
							["]C"] = { query = "@class.outer", desc = "Next class end" },
							["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
							["]F"] = { query = "@function.outer", desc = "Next function end" },
							["]L"] = { query = "@loop.outer", desc = "Next loop end" },
							["]A"] = { query = "@parameter.outer", desc = "Next parameter end" },
						},
						goto_previous_start = {
							["[c"] = { query = "@class.outer", desc = "Previous class start" },
							["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
							["[f"] = { query = "@function.outer", desc = "Previous function start" },
							["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
							["[a"] = { query = "@parameter.outer", desc = "Previous parameter start" },
						},
						goto_previous_end = {
							["[C"] = { query = "@class.outer", desc = "Previous class end" },
							["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
							["[F"] = { query = "@function.outer", desc = "Previous function end" },
							["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
							["[A"] = { query = "@parameter.outer", desc = "Previous parameter end" },
						},

						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						-- goto_next = {
						-- 	["]d"] = "@conditional.outer",
						-- },
						-- goto_previous = {
						-- 	["[d"] = "@conditional.outer",
						-- },
					},
				},
			})
		end,
	},
}
