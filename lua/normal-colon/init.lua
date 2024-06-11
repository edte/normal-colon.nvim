-- local M = {}

-- function M.setup(opts)
-- 	opts = opts or {}
-- 	vim.api.nvim_set_keymap("n", ";", "v:lua.AlphaGotoNext(';')", { expr = true })
-- 	vim.api.nvim_set_keymap("n", ",", "v:lua.AlphaGotoNext(',', 1)", { expr = true })

-- 	vim.api.nvim_set_keymap("x", ";", "v:lua.AlphaGotoNext(';')", { expr = true })
-- 	vim.api.nvim_set_keymap("x", ",", "v:lua.AlphaGotoNext(',', 1)", { expr = true })

-- 	vim.api.nvim_set_keymap("n", "f", "v:lua.AlphaGoto('f')", { expr = true })
-- 	vim.api.nvim_set_keymap("n", "F", "v:lua.AlphaGoto('F')", { expr = true })
-- 	vim.api.nvim_set_keymap("n", "t", "v:lua.AlphaGoto('t')", { expr = true })
-- 	vim.api.nvim_set_keymap("n", "T", "v:lua.AlphaGoto('T')", { expr = true })

-- 	vim.api.nvim_set_keymap("x", "f", "v:lua.AlphaGoto('f')", { expr = true })
-- 	vim.api.nvim_set_keymap("x", "F", "v:lua.AlphaGoto('F')", { expr = true })
-- 	vim.api.nvim_set_keymap("x", "t", "v:lua.AlphaGoto('t')", { expr = true })
-- 	vim.api.nvim_set_keymap("x", "T", "v:lua.AlphaGoto('T')", { expr = true })

-- 	function AlphaGoto(cmd)
-- 		local ch
-- 		while true do
-- 			vim.cmd("redraw")
-- 			vim.cmd("echo '" .. cmd .. "> '")
-- 			ch = vim.fn.getcharstr()
-- 			if ch ~= "<CursorHold>" then
-- 				break
-- 			end
-- 		end
-- 		vim.cmd("echo '" .. ch .. "'")
-- 		vim.g.after_alpha_goto_do = 2
-- 		vim.g.after_alpha_goto_time = vim.fn.reltimefloat(vim.fn.reltime())
-- 		return cmd .. ch
-- 	end

-- 	function AlphaGotoNext(cmd, always)
-- 		always = always or 0
-- 		if not vim.g.after_alpha_goto_do and always == 0 then
-- 			return ":"
-- 		end

-- 		vim.g.after_alpha_goto_do = 2
-- 		vim.g.after_alpha_goto_time = vim.fn.reltimefloat(vim.fn.reltime())
-- 		return cmd
-- 	end
-- end

-- return M

local M = {}

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_exec(
		[[
nnoremap <expr> ; AlphaGotoNext(';')
nnoremap <expr> , AlphaGotoNext(',', 1)

xnoremap <expr> ; AlphaGotoNext(';')
xnoremap <expr> , AlphaGotoNext(',', 1)


nnoremap <expr> f AlphaGoto('f')
nnoremap <expr> F AlphaGoto('F')
nnoremap <expr> t AlphaGoto('t')
nnoremap <expr> T AlphaGoto('T')

xnoremap <expr> f AlphaGoto('f')
xnoremap <expr> F AlphaGoto('F')
xnoremap <expr> t AlphaGoto('t')
xnoremap <expr> T AlphaGoto('T')


let g:after_alpha_goto_do = 0

aug AlphaGoto
    au!
    au CursorMoved *
                \   if g:after_alpha_goto_do == 2
                \           && reltimefloat(reltime())
                \               - g:after_alpha_goto_time
                \               > 0.3
                \ |     let g:after_alpha_goto_do = 0
                \ | el
                \ |     let g:after_alpha_goto_do -= g:after_alpha_goto_do > 0
                \ | en
aug end

function! AlphaGoto(cmd)
    while v:true
        redraw
        echon "\r" . a:cmd . '> '
        let ch = getcharstr()
        if ch != "\<CursorHold>"
            break
        endif
    endwhile
    echon ch
    let g:after_alpha_goto_do = 2
    let g:after_alpha_goto_time = reltimefloat(reltime())
    return a:cmd .. ch
endfunction
function! AlphaGotoNext(cmd, always = 0)
    if !get(g:, 'after_alpha_goto_do') && !a:always
        return ':'
    endif

    let g:after_alpha_goto_do = 2
    let g:after_alpha_goto_time = reltimefloat(reltime())
    return a:cmd
endfunction
" }}}
]],
		false
	)
end

return M
