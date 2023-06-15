if &cp || exists("g:loaded_easyescape")
    finish
endif
let g:loaded_easyescape = 1
let s:haspy3 = has("python3")

if !exists("g:easyescape_timeout")
    if s:haspy3
        let g:easyescape_timeout = 300
    else
        let g:easyescape_timeout = 300
    endif
endif

function! s:EasyescapeSetTimer()
    if s:haspy3
        py3 easyescape_time = reltimefloat(reltime())
    endif
    let s:localtime = localtime()
endfunction

function! s:EasyescapeReadTimer()
    if s:haspy3
        py3 vim.command("let pyresult = reltimefloat(reltime()) - easyescape_time")
        return pyresult
    endif
    return reltime() - s:localtime
endfunction

function! <SID>EasyescapeCheckExit()
    if s:EasyescapeReadTimer() > g:easyescape_timeout
        stopinsert
    endif
endfunction

augroup easyescape
    au!
    au CursorMovedI * call <SID>EasyescapeCheckExit()
    au InsertLeave * call <SID>EasyescapeCheckExit()
augroup END

if s:haspy3
    py3 from time import reltime, reltimefloat
    py3 import vim
    call s:EasyescapeSetTimer()
else
    let s:localtime = localtime()
endif
