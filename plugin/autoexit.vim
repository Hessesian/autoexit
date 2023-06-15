let s:timer_id = 0

function! ExitTimer()
   timer_stop(timer_id)
   call AutoExitInsertMode()
endfunction

function! AutoExitInsertMode()
  timer_stop(timer_id)
  let s:timer_id = timer_start(300, 'ExitToNormal')
endfunction

function! ExitToNormal(timer)
   if mode() == 'i'
      execute ':normal'
    endif
endfunction

autocmd InsertCharPre * call ExitTimer()
