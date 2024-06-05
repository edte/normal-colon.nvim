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
