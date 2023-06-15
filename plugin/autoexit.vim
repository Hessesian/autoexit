let s:idleexit_timer = 0
if !exists('g:idle_timeout')
    let g:idle_timeout= 600
endif
function! IdleExitCallback(timer_id)
    stopinsert
endfunction

function! IdleExitStart()
    if s:idleexit_timer != 0
        call timer_stop(s:idleexit_timer)
        let s:idleexit_timer = 0
    endif
    let s:idleexit_timer = timer_start(g:idle_timeout, 'IdleExitCallback')
endfunction

function! IdleExitStop()
    if s:idleexit_timer != 0
        call timer_stop(s:idleexit_timer)
        let s:idleexit_timer = 0
    endif
endfunction

augroup idleExit
    autocmd!
    autocmd InsertCharPre * call IdleExitStart()
    autocmd InsertLeave * call IdleExitStop()
augroup END
