function! AutoExitInsert()
  if mode() == 'i'
    sleep 300
    execute 'normal! esc'
  endif
endfunction

autocmd InsertEnter * call AutoExitInsert()
