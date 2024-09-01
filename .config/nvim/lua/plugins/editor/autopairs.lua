return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				enable_check_bracket_line = false,
			})

			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- Add spaces between parentheses
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
			npairs.add_rules({
				-- Rule for a pair with left-side ' ' and right side ' '
				Rule(" ", " ")
					-- Pair will only occur if the conditional function returns true
					:with_pair(function(opts)
						-- We are checking if we are inserting a space in (), [], or {}
						local pair = opts.line:sub(opts.col - 1, opts.col)
						return vim.tbl_contains({
							brackets[1][1] .. brackets[1][2],
							brackets[2][1] .. brackets[2][2],
							brackets[3][1] .. brackets[3][2],
						}, pair)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
					-- We only want to delete the pair of spaces when the cursor is as such: ( | )
					:with_del(
						function(opts)
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local context = opts.line:sub(col - 1, col + 2)
							return vim.tbl_contains({
								brackets[1][1] .. "  " .. brackets[1][2],
								brackets[2][1] .. "  " .. brackets[2][2],
								brackets[3][1] .. "  " .. brackets[3][2],
							}, context)
						end
					),
			})
			-- For each pair of brackets we will add another rule
			for _, bracket in pairs(brackets) do
				npairs.add_rules({
					-- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
					Rule(bracket[1] .. " ", " " .. bracket[2])
						:with_pair(cond.none())
						:with_move(function(opts)
							return opts.char == bracket[2]
						end)
						:with_del(cond.none())
						:use_key(bracket[2])
						-- Removes the trailing whitespace that can occur without this
						:replace_map_cr(function(_)
							return "<C-c>2xi<CR><C-c>O"
						end),
				})
			end

			-- Insertion with surrounding check
			local rule2 = function(a1, ins, a2, lang)
				npairs.add_rule(Rule(ins, ins, lang)
					:with_pair(function(opts)
						return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
					:with_del(function(opts)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
					end))
			end
			rule2("(", "*", ")", "ocaml")
			rule2("(*", " ", "*)", "ocaml")
			rule2("(", " ", ")")

			-- Expand multiple pairs on enter key
			local get_closing_for_line = function(line)
				local i = -1
				local clo = ""

				while true do
					i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
					if i == nil then
						break
					end
					local ch = string.sub(line, i, i)
					local st = string.sub(clo, 1, 1)

					if ch == "{" then
						clo = "}" .. clo
					elseif ch == "}" then
						if st ~= "}" then
							return ""
						end
						clo = string.sub(clo, 2)
					elseif ch == "(" then
						clo = ")" .. clo
					elseif ch == ")" then
						if st ~= ")" then
							return ""
						end
						clo = string.sub(clo, 2)
					elseif ch == "[" then
						clo = "]" .. clo
					elseif ch == "]" then
						if st ~= "]" then
							return ""
						end
						clo = string.sub(clo, 2)
					end
				end

				return clo
			end
			npairs.remove_rule("(")
			npairs.remove_rule("{")
			npairs.remove_rule("[")

			npairs.add_rule(Rule("[%(%{%[]", "")
				:use_regex(true)
				:replace_endpair(function(opts)
					return get_closing_for_line(opts.line)
				end)
				:end_wise(function(opts)
					-- Do not endwise if there is no closing
					return get_closing_for_line(opts.line) ~= ""
				end))
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
			})

			-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
			-- 	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- 		underline = true,
			-- 		virtual_text = {
			-- 			spacing = 5,
			-- 			severity_limit = "Warning",
			-- 		},
			-- 		update_in_insert = true,
			-- 	})
		end,
	},
}
