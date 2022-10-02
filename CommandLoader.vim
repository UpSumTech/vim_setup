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

function s:CopyLineToClipboard()
  if g:os == 'Darwin'
    execute '.w !pbcopy'
  elseif g:os == 'Linux'
    execute '.w !xclip -selection clipboard'
  endif
endfunction

function s:PasteLineFromClipboard()
  if &paste
    if g:os == 'Darwin'
      execute 'r !pbpaste'
    elseif g:os == 'Linux'
      execute 'r !xclip -selection clipboard -o'
    endif
  else
    set paste
    if g:os == 'Darwin'
      execute ":r !pbpaste"
    elseif g:os == 'Linux'
      execute ':r !xclip -selection clipboard -o'
    endif
    set nopaste
  endif
endfunction

function s:OpenConsoleOnTmux()
  if executable('tmux')
    if !exists('g:current_tmux_session') && !exists('g:vim_tmux_window')
      let l:temp_current_tmux_session = substitute(system('tmux display-message -p '.shellescape('"#{session_id}"')), '"', '', 'g')
      let g:current_tmux_session = substitute(l:temp_current_tmux_session, '\n', '', 'g')
      let l:temp_vim_tmux_window = substitute(system('tmux display-message -p '.shellescape('"#{window_id}"')), '"', '', 'g')
      let g:vim_tmux_window = substitute(l:temp_vim_tmux_window, '\n', '', 'g')
      let l:temp_vim_tmux_pane = substitute(system('tmux display-message -p '.shellescape('"#{pane_id}"')), '"', '', 'g')
      let g:vim_tmux_pane = substitute(l:temp_vim_tmux_pane, '\n', '', 'g')
    endif
    if !exists('g:vim_tmux_console_pane')
      let g:vim_tmux_console_pane = 1
      execute '!tmux split-window -d -v -p 15 -t '.g:vim_tmux_window
    endif
  endif
endfunction

function s:CloseConsoleOnTmux()
  if executable('tmux')
    if exists('g:vim_tmux_console_pane')
      let l:temp_tmux_pane_to_close = substitute(system('tmux list-panes -F '.shellescape('"#{pane_id}"').' -t '.shellescape(g:vim_tmux_window).' | grep -v '.shellescape(g:vim_tmux_pane).' | sort -r | head -n 1'), '"', '', 'g')
      let l:tmux_pane_to_close = substitute(substitute(l:temp_tmux_pane_to_close, '\n', '', 'g'), '%', '', 'g')
      execute '!tmux kill-pane -t '.shellescape('\%'.l:tmux_pane_to_close)
      unlet g:vim_tmux_console_pane
    end
  end
endfunction

function s:GitPullReload()
  set noconfirm
  execute '!git pull'
  bufdo e!
  set confirm
endfunction

function s:SearchAndReplace(search, replace)
  set noconfirm
  execute '!find . -not -iwholename "*.git*" -type f -exec sed -i "s/'.a:search.'/'.a:replace.'/g" {} \;'
  bufdo e!
  set confirm
endfunction

function s:InstallLspServers()
  for item in items(g:language_servers)
    if &ft == item[0] && index(g:lsp_servers_installed, item[1]) < 0
      execute 'LspInstallServer'
    endif
  endfor
endfunction

function CommandLoader#Load() dict
  " Commands
  command! BClose call <SID>BufferClose()
  command! QfToggle call <SID>QuickfixToggle()
  command! LastTab call <SID>GotoLastTab()
  command! -nargs=+ -complete=command Windo call <SID>WinDo(<q-args>)
  command! -nargs=+ -complete=command Bufdo call <SID>BufDo(<q-args>)
  command! -nargs=+ -complete=command Tabdo call <SID>TabDo(<q-args>)
  command! RTSpaces call <SID>RemoveTrailingSpaces()
  command! OBrowser call <SID>OpenBrowser()
  command! PbLineCopy call <SID>CopyLineToClipboard()
  command! PbLinePaste call <SID>PasteLineFromClipboard()
  command! OpenConsole call <SID>OpenConsoleOnTmux()
  command! CloseConsole call <SID>CloseConsoleOnTmux()
  command! GitPullAndReload call <SID>GitPullReload()
  command! -nargs=+ -complete=command SearchAndReplaceAcrossProject call <SID>SearchAndReplace(<f-args>)
  command! -nargs=+ -complete=file -bar ProjectFind grep! <args>|cw

  " AutoCommands
  autocmd BufReadPost * call <SID>GotoLastEditLine()
  autocmd TabLeave * call <SID>MarkLastTab()
  autocmd BufWritePre * :call <SID>RemoveTrailingSpaces()
  autocmd BufNewFile,BufRead *.org,*.md setlocal spell spelllang=en_US complete+=kspell
  autocmd BufReadPost * call s:InstallLspServers()
endfunction CommandLoader#Load

function CommandLoader#New()
  let Retval = {
        \ 'load' : function('CommandLoader#Load'),
        \ }
  return Retval
endfunction CommandLoader#New
