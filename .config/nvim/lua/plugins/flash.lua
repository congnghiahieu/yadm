return {
	{
		"folke/flash.nvim",
		vscode = true,
		keys = {
			-- { "<space>f", mode = { "n", "x", "o" },  desc = "Flash" },
			-- { "<space>j", mode = { "n" }, function() require("flash").jump() end, desc = "Jump to (Flash)" },
			-- { "<space>J", mode = { "n" }, function() require("flash").treesitter() end, desc = "Jump by treesitter (Flash)" },
			-- { "<space>fr", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			-- { "<space>fs", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- { "<space>ft", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
			{ "f", mode = { "n" } },
			{ "F", mode = { "n" } },
			{ "t", mode = { "n" } },
			{ "T", mode = { "n" } },
		},
		---@type Flash.Config
		opts = {
			jump = {
				-- save location in the jumplist
				jumplist = true,
				-- jump position
				pos = "start", ---@type "start" | "end" | "range"
				-- add pattern to search history
				history = false,
				-- add pattern to search register
				register = false,
				-- clear highlight after jump
				nohlsearch = true,
				-- automatically jump when there is only one match
				autojump = true,
				-- You can force inclusive/exclusive jumps by setting the
				-- `inclusive` option. By default it will be automatically
				-- set based on the mode.
				inclusive = nil, ---@type boolean?
				-- jump position offset. Not used for range jumps.
				-- 0: default
				-- 1: when pos == "end" and pos < current position
				offset = nil, ---@type number
			},
			label = {
				-- allow uppercase labels
				uppercase = true,
				-- add any labels with the correct case here, that you want to exclude
				exclude = "",
				-- add a label for the first match in the current window.
				-- you can always jump to the first match with `<CR>`
				current = true,
				-- show the label after the match
				after = true, ---@type boolean|number[]
				-- show the label before the match
				before = false, ---@type boolean|number[]
				-- position of the label extmark
				style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
				-- flash tries to re-use labels that were already assigned to a position,
				-- when typing more characters. By default only lower-case labels are re-used.
				reuse = "all", ---@type "lowercase" | "all" | "none"
				-- for the current window, label targets closer to the cursor first
				distance = true,
				-- minimum pattern length to show labels
				-- Ignored for custom labelers.
				min_pattern_length = 0,
				-- Enable this to use rainbow colors to highlight labels
				-- Can be useful for visualizing Treesitter ranges.
				rainbow = {
					enabled = true,
					-- number between 1 and 9
					shade = 9,
				},
				-- With `format`, you can change how the label is rendered.
				-- Should return a list of `[text, highlight]` tuples.
				---@class Flash.Format
				---@field state Flash.State
				---@field match Flash.Match
				---@field hl_group string
				---@field after boolean
				---@type fun(opts:Flash.Format): string[][]
				format = function(opts)
					return { { opts.match.label, opts.hl_group } }
				end,
			},
			modes = {
				-- options used when flash is activated through
				-- a regular search with `/` or `?`
				search = {
					-- when `true`, flash will be activated during regular search by default.
					-- You can always toggle when searching with `require("flash").toggle()`
					enabled = false,
					highlight = { backdrop = false },
					jump = { history = true, register = true, nohlsearch = true },
					search = {
						-- `forward` will be automatically set to the search direction
						-- `mode` is always set to `search`
						-- `incremental` is set to `true` when `incsearch` is enabled
					},
				},
				-- options used when flash is activated through
				-- `f`, `F`, `t`, `T`, `;` and `,` motions
				char = {
					enabled = true,
					-- dynamic configuration for ftFT motions
					config = function(opts)
						-- autohide flash when in operator-pending mode
						opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

						-- disable jump labels when not enabled, when using a count,
						-- or when recording/executing registers
						opts.jump_labels = opts.jump_labels
							and vim.v.count == 0
							and vim.fn.reg_executing() == ""
							and vim.fn.reg_recording() == ""

						-- Show jump labels only in operator-pending mode
						-- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
					end,
					-- hide after jump when not using jump labels
					autohide = true,
					-- show jump labels
					jump_labels = true,
					-- set to `false` to use the current line only
					multi_line = true,
					-- When using jump labels, don't use these keys
					-- This allows using those keys directly after the motion
					label = { exclude = "hjkliardc" },
					-- by default all keymaps are enabled, but you can disable some of them,
					-- by removing them from the list.
					-- If you rather use another key, you can map them
					-- to something else, e.g., { [";"] = "L", [","] = H }
					keys = { "f", "F", "t", "T" },
					---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
					-- The direction for `prev` and `next` is determined by the motion.
					-- `left` and `right` are always left and right.
					char_actions = function(motion)
						return {
							-- [";"] = "next", -- set to `right` to always go right
							-- [","] = "prev", -- set to `left` to always go left
							-- clever-f style
							[motion:lower()] = "next",
							[motion:upper()] = "prev",
							-- jump2d style: same case goes next, opposite case goes prev
							-- [motion] = "next",
							-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
						}
					end,
					search = { wrap = true },
					highlight = { backdrop = true },
					jump = { register = false },
				},
				-- options used for treesitter selections
				-- `require("flash").treesitter()`
				treesitter = {
					labels = "abcdefghijklmnopqrstuvwxyz",
					jump = { pos = "range" },
					search = { incremental = false },
					label = { before = true, after = true, style = "inline" },
					highlight = {
						backdrop = false,
						matches = false,
					},
				},
				treesitter_search = {
					jump = { pos = "range" },
					search = { multi_window = true, wrap = true, incremental = false },
					remote_op = { restore = true },
					label = { before = true, after = true, style = "inline" },
				},
				-- options used for remote flash
				remote = {
					remote_op = { restore = true, motion = true },
				},
			},
		},
	},
}
