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
    map <leader>ct :!ctags --exclude=.git --exclude=node_modules --exclude=vendor --exclude=target --exclude=bundle --exclude=tmp --exclude=temp -auR .<CR>

    " Map Ctrl+] to open file defining current word
    noremap <c-]> :execute "tag " . expand("<cword>")<cr>
  endif

  " Open the tag navigation menu for Vista
  nmap <c-t>t :Vista!!<CR>

  if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=1

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

  " The following maps all invoke one of the following cscope search types:
  "
  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
  endif

  " Settings for search with no magic. If you need special characters escape them with \
  nnoremap / /\V
  vnoremap / /\V
  cnoremap %s/ %snomagic/
  cnoremap \>s/ \>snomagic/
  nnoremap :g/ :g/\V
  nnoremap :g// :g//

  " Remap window commands
  nnoremap <Leader>= <C-w>=
  nnoremap <Leader>h <C-w>h
  nnoremap <Leader>j <C-w>j
  nnoremap <Leader>k <C-w>k
  nnoremap <Leader>l <C-w>l
  nnoremap <Leader>s <C-w>s
  nnoremap <Leader>v <C-w>v

  " Mappings for tabs
  nnoremap <leader><tab>n :tabnew<cr>
  nnoremap <leader><tab>o :tabonly<cr>
  nnoremap <leader><tab>c :tabclose<cr>
  nnoremap <leader><tab>m :tabmove
  nnoremap <leader><tab><leader> :tabnext
  nnoremap <Leader><tab>l :LastTab<CR>

  " Helpful mappings for opening windows
  nnoremap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
  nnoremap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
  nnoremap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
  nnoremap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

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

  " Git pull and reload the current buffer
  nnoremap <leader>gp :GitPullAndReload<CR><CR>

  " Toggle undo tree
  nnoremap <leader>ut :UndotreeToggle<CR>

  " Clear quickfix window
  nnoremap <leader>cq :cexpr []<CR>

  " Find for a word across the project
  nnoremap <leader>fp :ProjectFind<space>
endfunction MappingLoader#Load

function MappingLoader#New()
  let Retval = {
        \ 'load' : function('MappingLoader#Load'),
        \ }
  return Retval
endfunction MappingLoader#New
