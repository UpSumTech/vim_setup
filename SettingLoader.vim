function SettingLoader#Load() dict
  set modelines=0                                             " Dont allow file specific vim config
  set clipboard=unnamed                                       " Allow yank/delete etc to *
  set encoding=utf-8                                          " Allow utf-8
  set smarttab tabstop=2 shiftwidth=2 softtabstop=2 expandtab " Tabs/indenting/backspace are 2 space characters
  set shiftround                                              " Round indents to a multiple of 'shiftwidth'
  set list                                                    " Show invisible characters
  set backspace=indent,eol,start                              " Enable backspace for everything in insert mode
  set nofoldenable                                            " Kill automatic folding
  set nowrap                                                  " Display long lines as long lines
  set colorcolumn=80                                          " Highlight column no 80
  set number ruler                                            " Display line numbers
  set nowritebackup nobackup noswapfile                       " Do not create crazy backup/swap files
  set autowrite                                               " Automatically write before running commands
  set hlsearch incsearch ignorecase smartcase                 " Settings to highlight/search/step
  set lazyredraw
  set magic
  set mouse=a paste                                           " Do not copy line nos while copying to xterm and allow pasting from it seamlessly
  set showmatch                                               " Show the matching bracket
  set noerrorbells
  set novisualbell
  set matchpairs=(:),{:},[:],<:>                              " List of characters we expect in balanced pairs
  set wildmode=list:longest,full                              " Completion for wildchar in command mode
  set wildmenu
  set background=dark
  set completeopt=menu,longest
  set omnifunc=syntaxcomplete#Complete                        " This is overriden by syntax plugins.
  set laststatus=2                                            " TODO: Dont know wat this does

  set listchars=""          " Reset the listchars
  set listchars+=tab:\ \    " List tab as 2 spaces
  set listchars+=trail:.    " show trailing spaces as dots
  set listchars+=extends:>  " The character to show on the right column when wrap is off
  set listchars+=precedes:< " The character to show on the left when wrap is off

  set wildignore+=*.jpg,*.png,*.gif,*.jpeg
  set wildignore+=*.csv,*.xls,*.xlsx,*.doc,*.docx,*.pdf
  set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
  set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
  set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
  set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
  set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
  set wildignore+=*.swp,*~,._*
  set wildignore+=*.log

  if executable('ag')
    let g:ackprg="ag --nocolor --nogroup --column"
    set grepprg=ag\ --nogroup\ --nocolor " Use Ag over Grep
  endif

  let g:netrw_altv           = 1
  let g:netrw_fastbrowse     = 2
  let g:netrw_keepdir        = 0
  let g:netrw_liststyle      = 3
  let g:netrw_retmap         = 1
  let g:netrw_silent         = 1
  let g:netrw_special_syntax = 1

  if executable("psc")
    let g:purescript_indent_if = 3
    let g:purescript_indent_case = 5
    let g:purescript_indent_let = 4
    let g:purescript_indent_where = 6
    let g:purescript_indent_do = 3
  endif
endfunction SettingLoader#Load

function SettingLoader#New()
  let Retval = {
    \ 'load' : function('SettingLoader#Load'),
  \ }
  return Retval
endfunction SettingLoader#New
