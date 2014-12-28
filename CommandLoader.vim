function s:BufferClose()
  let l:currentBuffer = bufnr("%")
  let l:alternateBuffer = bufnr("#")

  if buflisted(l:alternateBuffer) && bufwinnr(l:alternateBuffer) <# 0
    buffer #
  else
    bnext
  endif

  if bufnr("%") ==# l:currentBuffer
    new
  endif

  if buflisted(l:currentBuffer)
    execute("bdelete! ".l:currentBuffer)
  endif
endfunction

function s:QuickfixToggle()
  if !exists('g:quickfix_is_open')
    let g:quickfix_is_open = 0
  endif

  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

function s:GotoLastEditLine()
  if line("'\"") ># 0 && line("'\"") <=# line("$")
    execute "normal! g`\""
  endif
endfunction

function s:MarkLastTab()
  if !exists('g:lasttab')
    let g:lasttab = 1
  endif
  let g:lasttab = tabpagenr()
endfunction

function s:GotoLastTab()
  if exists('g:lasttab')
    execute "tabnext ".g:lasttab
  else
    echom "No other tab to go to"
  endif
endfunction

function! WinDo(command)
  let currentWindow = winnr()
  execute 'windo ' . a:command
  execute currentWindow . 'wincmd w'
endfunction

function! BufDo(command)
  let currentBuffer=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currentBuffer
endfunction

function! TabDo(command)
  let currentTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currentTab
endfunction

function CommandLoader#Load() dict
  " Commands
  command! BClose call <SID>BufferClose()
  command! QfToggle call <SID>QuickfixToggle()
  command! LTab call <SID>GotoLastTab()
  command! -nargs=+ -complete=command Windo call WinDo(<q-args>)
  command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
  command! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)

  " AutoCommands
  autocmd BufReadPost * call <SID>GotoLastEditLine()
  autocmd TabLeave * call <SID>MarkLastTab()
endfunction CommandLoader#Load

function CommandLoader#New()
  let Retval = {
        \ 'load' : function('CommandLoader#Load'),
        \ }
  return Retval
endfunction CommandLoader#New
