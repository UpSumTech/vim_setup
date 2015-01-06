function PluginLoader#Install() dict
  if executable('git') && has('autocmd')
    if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
      echomsg 'Wait....Setting up vim'
      silent !mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    endif
  endif
endfunction PluginLoader#Install

function PluginLoader#BeforeLoad() dict
  filetype off
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  return
endfunction PluginLoader#BeforeLoad

function s:BundlePlugins()
  if filereadable(expand("~/.vim/plugins.vim"))
    source ~/.vim/plugins.vim
  endif
  if exists("g:plugins")
    for plugin in g:plugins
      :execute "NeoBundle ".plugin
    endfor
  endif
endfunction

function s:LoadFileBrowserSettings()
  nmap <leader>n :NERDTreeToggle<CR>
  nmap <leader>nf :NERDTreeFind<CR>
  let NERDTreeQuitOnOpen=1
  let NERDTreeShowHidden=2
  let NERDTreeIgnore = [
        \ 'tmp', '\.yardoc$', 'pkg', 'log', '\.map$', '\.swp$', '\.o$', '\.so$',
        \ '\.class$', '\.pyc$', '\.pyo$', '\.gif$', '\.jpg$', '\.png$', '\.git',
        \ '\.hg$', '\.svn$', '\.obj$', '\.ico$', '\.pyd$', '\.exe$', '\~$', '\.dll'
        \ ]
endfunction

function s:LoadFileFinderSettings()
  let g:ctrlp_max_files = 10000
  let g:ctrlp_max_depth = 100
  let g:ctrlp_match_window_reversed = 0
  if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
  endif
endfunction

function s:LoadLineCommenterSettings()
  " Command and uncomment code easily
  " <leader>cc -- comment ragged style
  " <leader>cl -- comment aligned style
  " <leader>cu -- uncomment
  " <leader>ci -- toggle comments
  let g:NERDRemoveExtraSpaces=1
  let g:NERDSpaceDelims=1
  let g:NERDCommentWholeLinesInVMode=2
endfunction

function s:LoadTabularizingSettings()
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
  nmap <leader>a, :Tabularize /,\zs<CR>
  vmap <leader>a, :Tabularize /,\zs<CR>
endfunction

function s:ToggleSyntaxCheck()
  let l:quickfixWindow = filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"')
  if !(exists('g:is_location_list_open'))
    let g:is_location_list_open = 0
  endif

  if empty(l:quickfixWindow) && !g:is_location_list_open
    let l:location_list_return_window = winnr()
    call SyntasticToggleMode()
    call SyntasticCheck()
    let g:is_location_list_open = 1
    execute l:location_list_return_window . "wincmd w"
    lopen
  else
    call SyntasticReset()
    call SyntasticToggleMode()
    let g:is_location_list_open = 0
    lclose
  endif
endfunction

function s:LoadSyntaxCheckingSettings()
  if exists('*getmatches')
    let g:is_posix                           = 1 " Syntax highlight shell scripts as per POSIX
    let g:syntastic_error_symbol             = '✗✗'
    let g:syntastic_warning_symbol           = '⚠⚠'
    let g:syntastic_style_error_symbol       = '✗'
    let g:syntastic_style_warning_symbol     = '⚠'
    let g:syntastic_always_populate_loc_list = 1 " Always open the location-list
    let g:syntastic_auto_loc_list            = 2 " Close the location-list when errors are gone
    let g:syntastic_loc_list_height          = 5
    let g:syntastic_sh_checkers              = ['shellcheck', 'checkbashisms', 'sh']
    let g:syntastic_sh_checkbashisms_args    = '-x'
    let g:syntastic_ruby_checkers            = ['mri', 'jruby', 'rubocop']
    let g:syntastic_javascript_checkers      = ['jshint']
    let g:syntastic_ruby_rubocop_args        = '--display-cop-names'
    let g:syntastic_scss_checkers            = ['sass']
    let g:syntastic_sass_checkers            = ['sass']
    let g:syntastic_yaml_checkers            = ['jsyaml'] " npm install js-yaml
    let g:syntastic_mode_map                 = {
          \ "mode": "passive",
          \ "active_filetypes": [],
          \ "passive_filetypes": []
          \ }

    command! TSyntaxCheck call <SID>ToggleSyntaxCheck()
    nnoremap <leader><space> :TSyntaxCheck<CR>
  endif
endfunction

function s:LoadWordMovementSettings()
  map <S-W> <Plug>CamelCaseMotion_w
  map <S-B> <Plug>CamelCaseMotion_b
  map <S-E> <Plug>CamelCaseMotion_e
endfunction

function s:LoadStatusBarSettings()
  let g:Powerline_symbols = 'fancy'
endfunction

function PluginLoader#Load() dict
  call s:BundlePlugins()
  call s:LoadFileBrowserSettings()
  call s:LoadFileFinderSettings()
  call s:LoadLineCommenterSettings()
  call s:LoadTabularizingSettings()
  call s:LoadSyntaxCheckingSettings()
  call s:LoadWordMovementSettings()
  call s:LoadStatusBarSettings()
  return
endfunction PluginLoader#Load

function PluginLoader#AfterLoad() dict
  call neobundle#end()
  NeoBundleCheck
  syntax enable
  filetype plugin indent on
  color solarized
  return
endfunction PluginLoader#AfterLoad

function PluginLoader#New()
  let Retval = {
        \ 'install'    : function('PluginLoader#Install'),
        \ 'beforeLoad' : function('PluginLoader#BeforeLoad'),
        \ 'load'       : function('PluginLoader#Load'),
        \ 'afterLoad'  : function('PluginLoader#AfterLoad'),
        \ }
  return Retval
endfunction PluginLoader#New
