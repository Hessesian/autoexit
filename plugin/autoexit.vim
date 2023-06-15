function! AutoExitInsertMode()
      stoptimer timer_id
  let s:timer_id = timer_start(300, 'AutoExitInsertMode')
    if mode() == 'i'
      execute ':normal'
    endif
endfunction

autocmd InsertCharPre* call AutoExitInsertMode()
