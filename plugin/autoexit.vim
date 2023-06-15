" Set the idle time threshold in milliseconds
let g:idle_timeout = 300

" Variable to keep track of the last activity time
let g:last_activity = reltime()

" Define the Timer function
function! AutoExitTimer()
  " Calculate the time elapsed since the last activity
  let l:elapsed_time = reltimefloat(reltime(g:last_activity))

  " Convert the idle timeout to milliseconds
  let l:idle_timeout_ms = g:idle_timeout

  " Check if the elapsed time exceeds the idle timeout threshold
  if l:elapsed_time >= l:idle_timeout_ms / 1000.0
    " Perform any necessary cleanup or save operations here
    " ...

    " Quit Vim after the idle timeout
    quitall!
  endif
endfunction

" Define the CursorHold event callback
function! OnCursorHold()
  " Update the last activity time whenever the cursor is moved
  let g:last_activity = reltime()
endfunction

" Set up the Timer and event callbacks
augroup AutoExit
  autocmd!
  autocmd CursorHold * call OnCursorHold()
  autocmd TimerAutoExit <buffer> call AutoExitTimer()
augroup END
