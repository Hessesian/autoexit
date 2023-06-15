function! AutoExitInsertMode()
  let timer_id = timer_start(300, 'AutoExitInsertMode')

  function! AutoExitInsertMode(timer_id)
    if mode() == 'i'
      stoptimer timer_id
      execute ':normal'
    endif
  endfunction
endfunction

autocmd InsertEnter * call AutoExitInsertMode()
