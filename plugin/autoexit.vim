function! AutoExitInsertMode()
  let s:timer_id = timer_start(300, 'ExitToNormal')
  stoptimer timer_id
endfunction

function! ExitToNormal(){
   if mode() == 'i'
      execute ':normal'
    endif
}

autocmd InsertCharPre* call AutoExitInsertMode()
