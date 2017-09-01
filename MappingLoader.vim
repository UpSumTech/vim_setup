function MappingLoader#Load() dict
  " Jump to the next row on long lines
  nnoremap j gj
  nnoremap k gk

  " Make Y behave like other capitals
  map Y y$

  " Close current buffer
  nnoremap <leader>bd :BClose<CR>

  " Toggle Quickfix window
  nnoremap <leader>q :QfToggle<CR>

  " Mappings to toggle and clear search highlights
  nmap <leader>hs :set hlsearch! hlsearch?<CR>
  nmap <leader>hl :let @/ = ""<CR>

  " format the entire file
  nmap <leader>fef gg=G

  " upper/lower word
  nmap <leader>u mQviwU`Q
  nmap <leader>l mQviwu`Q

  " upper/lower first char of word
  nmap <leader>U mQgewvU`Q
  nmap <leader>L mQgewvu`Q

  " find merge conflict markers
  nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

  " open links in browser
  nnoremap <leader>ob :OBrowser<CR>

  if executable('ctags')
    " Index ctags from any project, including those outside Rails
    map <leader>ct :!ctags -auR .<CR>

    " Map Ctrl+] to open file defining current word
    noremap <c-]> :execute "tag " . expand("<cword>")<cr>
  endif

  " Settings for search with no magic. If you need special characters escape them with \
  nnoremap / /\V
  vnoremap / /\V
  cnoremap %s/ %snomagic/
  cnoremap \>s/ \>snomagic/
  nnoremap :g/ :g/\V
  nnoremap :g// :g//

  " Remap window commands
  nmap <Leader>= <C-w>=
  nmap <Leader>h <C-w>h
  nmap <Leader>j <C-w>j
  nmap <Leader>k <C-w>k
  nmap <Leader>l <C-w>l
  nmap <Leader>s <C-w>s
  nmap <Leader>v <C-w>v

  " Mappings for tabs
  nnoremap <leader><tab>n :tabnew<cr>
  nnoremap <leader><tab>o :tabonly<cr>
  nnoremap <leader><tab>c :tabclose<cr>
  nnoremap <leader><tab>m :tabmove
  nnoremap <leader><tab><leader> :tabnext
  nnoremap <Leader><tab>l :LastTab<CR>

  " Helpful mappings for opening windows
  nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
  nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
  nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
  nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

  " cd to the directory containing the file in the buffer
  nmap <silent> <leader>cd :lcd %:h<CR>

  " Create the directory containing the file in the buffer
  nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

  " Create mappings for copy/paste from clipboard
  nnoremap <leader>lc :PbLineCopy<CR>
  nnoremap <leader>lp :PbLinePaste<CR>

  " Create mappings for opening console
  nnoremap <leader>po :OpenConsole<CR><CR>
  nnoremap <leader>pc :CloseConsole<CR><CR>

  " Search word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endfunction MappingLoader#Load

function MappingLoader#New()
  let Retval = {
        \ 'load' : function('MappingLoader#Load'),
        \ }
  return Retval
endfunction MappingLoader#New
