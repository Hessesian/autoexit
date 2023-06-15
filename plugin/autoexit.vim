if &cp || exists("g:loaded_easyescape")
    finish
endif
let g:loaded_easyescape = 1
let s:haspy3 = has("python3")

if !exists("g:easyescape_chars")
    let g:easyescape_chars = { "j": 1, "k": 1 }
endif
if !exists("g:easyescape_timeout")
    if s:haspy3
        let g:easyescape_timeout = 100
    else
        let g:easyescape_timeout = 300
    endif
endif

if !s:haspy3 && g:easyescape_timeout < 2000
    echomsg "Python3 is required when g:easyescape_timeout < 2000"
    let g:easyescape_timeout = 2000
endif

function! s:EasyescapeInsertCharPre()
    if has_key(g:easyescape_chars, v:char) == 0
        let s:current_chars = copy(g:easyescape_chars)
    endif
endfunction

function! s:EasyescapeSetTimer()
    if s:haspy3
        py3 easyescape_time = float2nr(reltimefloat(reltime()))
    endif
    let s:localtime = localtime()
endfunction

function! s:EasyescapeReadTimer()
    if s:haspy3
        py3 vim.command("let pyresult = float2nr(reltimefloat(reltime()) - easyescape_time) * 1000")
        return pyresult
    endif
    return (reltime() - s:localtime)['m'] * 1000
endfunction

function! <SID>EasyescapeMap(char)
    if exists("b:easyescape_disable") && b:easyescape_disable == 1
        return a:char
    endif
    if s:current_chars[a:char] == 0
        let s:current_chars = copy(g:easyescape_chars)
        let s:current_chars[a:char] = s:current_chars[a:char] - 1
        call s:EasyescapeSetTimer()
        return a:char
    endif

    if s:EasyescapeReadTimer() > g:easyescape_timeout
        if strlen(v:char) == 0
            stopinsert
            return ""
        else
            let s:current_chars = copy(g:easyescape_chars)
            call s:EasyescapeSetTimer()
            return a:char
        endif
    endif

    let s:current_chars[a:char] = s:current_chars[a:char] - 1
    for value in values(s:current_chars)
        if value > 0
            call s:EasyescapeSetTimer()
            return a:char
        endif
    endfor

    let s:current_chars = copy(g:easyescape_chars)

    return a:char
endfunction

let s:current_chars = copy(g:easyescape_chars)

augroup easyescape
    au!
    au InsertCharPre * call s:EasyescapeInsertCharPre()
augroup END

for key in keys(g:easyescape_chars)
    exec "inoremap <expr> " . key . " <SID>EasyescapeMap(\"" . key . "\")"
endfor

if s:haspy3
    py3 from time import reltime, reltimefloat
    py3 import vim
    call s:EasyescapeSetTimer()
else
    let s:localtime = localtime()
endif
