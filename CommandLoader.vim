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

function! s:QuickfixToggle()
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

function CommandLoader#Load() dict
  command! BClose call <SID>BufferClose()
  command! QfToggle call <SID>QuickfixToggle()
endfunction CommandLoader#Load

function CommandLoader#New()
  let Retval = {
        \ 'load' : function('CommandLoader#Load'),
        \ }
  return Retval
endfunction CommandLoader#New
