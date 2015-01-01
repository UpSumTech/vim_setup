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

function s:WinDo(command)
  let currentWindow = winnr()
  execute 'windo ' . a:command
  execute currentWindow . 'wincmd w'
endfunction

function s:BufDo(command)
  let currentBuffer=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currentBuffer
endfunction

function s:TabDo(command)
  let currentTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currentTab
endfunction

function s:RemoveTrailingSpaces()
  let currentCursor = getpos(".")
  if !&bin && &filetype !=# 'diff'
    silent! %s/\s\+$//ge
  endif
  call setpos('.', currentCursor)
endfunction

function s:OpenBrowser()
  let l:link = matchstr(getline('.'), 'http[s]\?:\/\/[\da-z\.-]\+\.[a-z]\{2,6\}[^ >,;]*')
  if !empty(l:link)
    execute "!open ".l:link
    redraw!
  endif
endfunction

function CommandLoader#Load() dict
  " Commands
  command! BClose call <SID>BufferClose()
  command! QfToggle call <SID>QuickfixToggle()
  command! LTab call <SID>GotoLastTab()
  command! -nargs=+ -complete=command Windo call <SID>WinDo(<q-args>)
  command! -nargs=+ -complete=command Bufdo call <SID>BufDo(<q-args>)
  command! -nargs=+ -complete=command Tabdo call <SID>TabDo(<q-args>)
  command! RTSpaces call <SID>RemoveTrailingSpaces()
  command! OBrowser call <SID>OpenBrowser()

  " AutoCommands
  autocmd BufReadPost * call <SID>GotoLastEditLine()
  autocmd TabLeave * call <SID>MarkLastTab()
  autocmd BufWritePre * :call <SID>RemoveTrailingSpaces()
  autocmd BufNewFile,BufRead *.org setlocal spell spelllang=en
endfunction CommandLoader#Load

function CommandLoader#New()
  let Retval = {
        \ 'load' : function('CommandLoader#Load'),
        \ }
  return Retval
endfunction CommandLoader#New
