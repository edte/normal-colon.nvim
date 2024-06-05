local M = {}

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_set_keymap("n", ";", "v:lua.AlphaGotoNext(';')", { expr = true })
	vim.api.nvim_set_keymap("n", ",", "v:lua.AlphaGotoNext(',', 1)", { expr = true })

	vim.api.nvim_set_keymap("x", ";", "v:lua.AlphaGotoNext(';')", { expr = true })
	vim.api.nvim_set_keymap("x", ",", "v:lua.AlphaGotoNext(',', 1)", { expr = true })

	vim.api.nvim_set_keymap("n", "f", "v:lua.AlphaGoto('f')", { expr = true })
	vim.api.nvim_set_keymap("n", "F", "v:lua.AlphaGoto('F')", { expr = true })
	vim.api.nvim_set_keymap("n", "t", "v:lua.AlphaGoto('t')", { expr = true })
	vim.api.nvim_set_keymap("n", "T", "v:lua.AlphaGoto('T')", { expr = true })

	vim.api.nvim_set_keymap("x", "f", "v:lua.AlphaGoto('f')", { expr = true })
	vim.api.nvim_set_keymap("x", "F", "v:lua.AlphaGoto('F')", { expr = true })
	vim.api.nvim_set_keymap("x", "t", "v:lua.AlphaGoto('t')", { expr = true })
	vim.api.nvim_set_keymap("x", "T", "v:lua.AlphaGoto('T')", { expr = true })

	function AlphaGoto(cmd)
		local ch
		while true do
			vim.cmd("redraw")
			vim.cmd("echo '" .. cmd .. "> '")
			ch = vim.fn.getcharstr()
			if ch ~= "<CursorHold>" then
				break
			end
		end
		vim.cmd("echo '" .. ch .. "'")
		vim.g.after_alpha_goto_do = 2
		vim.g.after_alpha_goto_time = vim.fn.reltimefloat(vim.fn.reltime())
		return cmd .. ch
	end

	function AlphaGotoNext(cmd, always)
		always = always or 0
		if not vim.g.after_alpha_goto_do and always == 0 then
			return ":"
		end

		vim.g.after_alpha_goto_do = 2
		vim.g.after_alpha_goto_time = vim.fn.reltimefloat(vim.fn.reltime())
		return cmd
	end
end

return M
