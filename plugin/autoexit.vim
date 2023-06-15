function! ExitTimer()
   call timer_stopall()
   call AutoExitInsertMode()
endfunction

function! AutoExitInsertMode()
  let s:timer_id = timer_start(300, 'ExitToNormal')
endfunction

function! ExitToNormal(timer)
   if mode() == 'i'
      execute ':normal'
    endif
endfunction

autocmd InsertCharPre * call ExitTimer()
