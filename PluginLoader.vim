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
        \ '\.class$', 'target', '\.pyc$', '\.pyo$', '\.gif$', '\.jpg$', '\.png$', '\.git',
        \ '\.hg$', '\.svn$', '\.obj$', '\.ico$', '\.pyd$', '\.exe$', '\~$',
        \ '\.svg$', '\.jpeg$', '\.swo$', '\.retry$', '\.dll$', '\.log$', '\.psd$'
        \ ]
endfunction

function s:LoadFileFinderSettings()
  let g:ctrlp_max_files = 10000
  let g:ctrlp_max_depth = 100
  let g:ctrlp_match_window_reversed = 0
  if executable('ag')
    let g:ctrlp_user_command = 'ag %s -U -l --nocolor -g ""'
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
  nmap <leader>a%% :Tabularize /\ %%\ <CR>
  vmap <leader>a%% :Tabularize /\ %%\ <CR>
  nmap <leader>a% :Tabularize /\ %\ <CR>
  vmap <leader>a% :Tabularize /\ %\ <CR>
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

function s:LoadJavascriptSyntaxSettings()
  let g:javascript_plugin_jsdoc = 1
  let g:javascript_plugin_ngdoc = 1
  let g:javascript_plugin_flow = 1
  let g:jsx_ext_required = 1
endfunction

function s:LoadLinterSettings()
  let g:ale_fixers = {
  \  'javascript': ['prettier'],
  \  'jsx': ['prettier'],
  \  'css': ['prettier'],
  \}
  let g:ale_linters = {
  \  'javascript': ['stylelint', 'eslint'],
  \  'jsx': ['stylelint', 'eslint'],
  \}
  let g:ale_linter_aliases = {'jsx': 'css'}
  " Do not lint or fix minified files.
  let g:ale_pattern_options = {
  \  '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
  \  '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
  \}
  let g:ale_lint_on_enter = 0
  " Dont fix the files when saving
  let g:ale_fix_on_save = 0
endfunction

function s:LoadCodeSnippetHelpers()
  let g:user_emmet_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \}
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
    let g:syntastic_check_on_open            = 0 " Check syntax when a file is opened
    let g:syntastic_check_on_wq              = 0 " Disable syntax check when file is written to or closed
    let g:syntastic_sh_checkers              = ['shellcheck', 'checkbashisms', 'sh']
    let g:syntastic_sh_checkbashisms_args    = '-x'
    " let g:syntastic_ruby_checkers            = ['mri', 'jruby', 'rubocop']
    " let g:syntastic_python_checkers          = ['pylint']
    let g:syntastic_json_checkers            = ['jsonlint']
    let g:syntastic_terraform_checkers       = ['tflint']
    " let g:syntastic_ruby_rubocop_args        = '--display-cop-names'
    let g:syntastic_scss_checkers            = ['sass']
    let g:syntastic_sass_checkers            = ['sass']
    let g:syntastic_yaml_checkers            = ['jsyaml'] " npm install js-yaml
    " let g:syntastic_go_checkers              = ['gometalinter'] " go get github.com/alecthomas/gometalinter && gometalinter --install
    " let g:syntastic_mode_map                 = {
          " \ "mode": "passive",
          " \ "active_filetypes": [],
          " \ "passive_filetypes": ["go"]
          " \ }

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

function s:LoadGitGutterSettings()
  let g:gitgutter_sign_column_always = 1 " Always display the signs column
  let g:gitgutter_max_signs = 200  " Max changes to show in a buffer
  let g:gitgutter_diff_args = '-w' " Ignores white spaces on git diff
endfunction

function s:LoadFugitiveSettings()
  nnoremap <leader>gs :Gstatus<CR>
  nnoremap <leader>gr :Gremove<CR>
  nnoremap <leader>gb :Gblame<CR>
  nnoremap <leader>gw :Gwrite<CR>
  nnoremap <leader>gc :Gcommit<CR>
  nnoremap <leader>gd :Gdiff<CR>
endfunction

function s:LoadSplitJoinSettings()
  nnoremap sj :SplitjoinSplit<CR>
  nnoremap sk :SplitjoinJoin<CR>
  let g:UltiSnipsExpandTrigger="<TAB>"
  let g:UltiSnipsJumpForwardTrigger="<TAB>"
  let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
endfunction

function s:LoadIndentLineSettings()
  let g:indentLine_color_term = 239
  let g:indentLine_color_gui = '#09AA08'
  let g:indentLine_char = '¦'
endfunction

function s:LoadVimMakeSettings()
  let g:vimmake_save = 1
  let g:vimmake_path = '~/.vim/tools'
  autocmd BufNewFile,BufRead vimmake.* nested setlocal filetype=sh
  let g:vimmake_mode = {}
  let g:vimmake_mode['go_get_project_deps'] = 'async'
  let g:vimmake_mode['go_test_project'] = 'async'
  let g:vimmake_mode['run'] = 'quickfix'
  let g:vimmake_mode['gen_cscope'] = 'async'
  augroup QuickfixStatus
    au! BufWinEnter quickfix setlocal statusline=%t\ [%{g:vimmake_build_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
  augroup END
  noremap <F5> :VimTool run<CR>
  inoremap <F5> <ESC>:VimTool run<CR>
  noremap <F6> :VimTool gen_cscope<CR>
endfunction

function s:ToggleNeomake()
  let l:quickfixWindow = filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"')
  if !(exists('g:is_location_list_open'))
    let g:is_location_list_open = 0
  endif

  if empty(l:quickfixWindow) && !g:is_location_list_open
    :execute "Neomake"
    let g:is_location_list_open = 1
  elseif !empty(l:quickfixWindow) && !g:is_location_list_open
    :execute "NeomakeCancelJobs"
    let g:is_location_list_open = 0
  else
    :execute "NeomakeCancelJobs"
    let g:is_location_list_open = 0
    lclose
  endif
endfunction

function s:LoadNeomakeSettings()
  let g:neomake_open_list = 2
  command! TNeomake call <SID>ToggleNeomake()
  nnoremap <c-m> :TNeomake<CR>
endfunction

function s:LoadEasyGrepSettings()
  let g:EasyGrepCommand=1 " Use grepprg for searching
  let g:EasyGrepMode=0 " Search all files
  let g:EasyGrepRecursive=1 " Use recursive search
  let g:EasyGrepIgnoreCase=1 " Ignore case during search
  let g:EasyGrepFilesToExclude=".svn,.git,tmp" " Ignore few dirs during search
  let g:EasyGrepWindow=0 " Use quickfix for the window
  let g:EasyGrepOpenWindowOnMatch=1 " Open the matched result in window
  let g:EasyGrepReplaceWindowMode=2 " Overwrite buffers during global replace
  let g:EasyGrepFileAssociations=$HOME."/.vim/plugin_configs/EasyGrepFileAssociations"
  map <silent> <c-g>v <plug>EgMapGrepCurrentWord_v
  vmap <silent> <c-g>v <plug>EgMapGrepSelection_v
  map <silent> <c-g>V <plug>EgMapGrepCurrentWord_V
  vmap <silent> <c-g>V <plug>EgMapGrepSelection_V
  map <silent> <c-g>a <plug>EgMapGrepCurrentWord_a
  vmap <silent> <c-g>a <plug>EgMapGrepSelection_a
  map <silent> <c-g>A <plug>EgMapGrepCurrentWord_A
  vmap <silent> <c-g>A <plug>EgMapGrepSelection_A
  map <silent> <c-g>r <plug>EgMapReplaceCurrentWord_r
  vmap <silent> <c-g>r <plug>EgMapReplaceSelection_r
  map <silent> <c-g>R <plug>EgMapReplaceCurrentWord_R
  vmap <silent> <c-g>R <plug>EgMapReplaceSelection_R
endfunction

function s:LoadJavaCompleteSettings()
  let g:JavaComplete_EnableDefaultMappings = 0
  let g:JavaComplete_ClosingBrace = 1
  " Uncomment the next line if it becomes a problem
  " let g:JavaComplete_AutoStartServer = 0 " Dont start the javavi server at start
  let g:JavaComplete_IgnoreErrorMsg = 1 " vim-lsp is doing the error checks, disable this for javacomplete2
endfunction

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  autocmd BufWritePre <buffer> call execute('LspCodeActionSync source.organizeImports')
  xnoremap <buffer> <silent> <c-l>t :LspTypeDefinition selection<CR>
  nnoremap <buffer> <silent> <c-l>th :LspTypeHierarchy<CR>
  nnoremap <buffer> <silent> <c-l>d :LspDefinition<CR>
  nnoremap <buffer> <silent> <c-]> :LspDefinition<CR>
  nnoremap <buffer> <silent> <c-l>i :LspImplementation<CR>
  nnoremap <buffer> <silent> <c-l>fef :LspDocumentFormat<CR>
  nnoremap <buffer> <silent> <c-l>f :LspDocumentFold<CR>
  nnoremap <buffer> <silent> <c-l>s :LspDocumentSymbol<CR>
  nnoremap <buffer> <silent> <c-l>r :LspRename<CR>
  nnoremap <buffer> <silent> <c-l>ne :LspNextError<CR>
  nnoremap <buffer> <silent> <c-l>pe :LspPreviousError<CR>
  nnoremap <buffer> <silent> <c-l>nw :LspNextWarning<CR>
  nnoremap <buffer> <silent> <c-l>pw :LspPreviousWarning<CR>
  nnoremap <buffer> <silent> <c-l>ar :LspReferences<CR>
  nnoremap <buffer> <silent> <c-l>nr :LspNextReference<CR>
  nnoremap <buffer> <silent> <c-l>pr :LspPreviousReference<CR>
  set foldmethod=expr
    \ foldexpr=lsp#ui#vim#folding#foldexpr()
    \ foldtext=lsp#ui#vim#folding#foldtext()
endfunction

function s:LoadVimLspSettings()
  augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function s:LoadTabAutoCompletion()
  let g:asyncomplete_auto_popup = 0
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ asyncomplete#force_refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
endfunction

function s:LoadVimAirlineSettings()
  let g:airline_solarized_bg='dark' " Use the dark solarized background for the tabline
  let g:airline#extensions#tagbar#enabled = 0 " Disable tagbar plugin
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " Displays filenames in the tabline
endfunction

function s:LoadVimVistaSettings()
  let g:vista_icon_indent = ["▸ ", ""] " How each level is indented and what to prepend
  let g:vista_default_executive = 'ctags' " Set the default tag generator for vista
  " Set the executive for some filetypes explicitly
  let g:vista_executive_for = {
    \ 'python': 'vim_lsp',
    \ 'java': 'vim_lsp',
    \ 'scala': 'vim_lsp',
    \ 'vim': 'vim_lsp',
    \ 'ruby': 'vim_lsp',
    \ 'javascript': 'vim_lsp',
    \ 'typescript': 'vim_lsp',
    \ 'groovy': 'vim_lsp',
    \ 'dockerfile': 'vim_lsp',
    \ 'bash': 'vim_lsp',
    \ }
  " Declare the command including the executable and options used to generate ctags output
  let g:vista_ctags_cmd = {
    \ 'go': 'gotags -silent -sort',
    \ }
endfunction

function PluginLoader#Load() dict
  call s:BundlePlugins()
  call s:LoadFileBrowserSettings()
  call s:LoadFileFinderSettings()
  call s:LoadLineCommenterSettings()
  call s:LoadTabularizingSettings()
  call s:LoadJavascriptSyntaxSettings()
  call s:LoadLinterSettings()
  call s:LoadSyntaxCheckingSettings()
  call s:LoadCodeSnippetHelpers()
  call s:LoadWordMovementSettings()
  call s:LoadStatusBarSettings()
  call s:LoadGitGutterSettings()
  call s:LoadFugitiveSettings()
  call s:LoadVimMakeSettings()
  call s:LoadEasyGrepSettings()
  call s:LoadSplitJoinSettings()
  call s:LoadIndentLineSettings()
  call s:LoadVimLspSettings()
  if exists('g:is_javacomplete2_plugin_enabled') && g:is_javacomplete2_plugin_enabled == 1
    call s:LoadJavaCompleteSettings()
  endif
  call s:LoadTabAutoCompletion()
  call s:LoadVimAirlineSettings()
  call s:LoadVimVistaSettings()
  return
endfunction PluginLoader#Load

function PluginLoader#AfterLoad() dict
  call neobundle#end()
  NeoBundleCheck
  syntax enable
  filetype plugin indent on
  color solarized
  call s:LoadNeomakeSettings()
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
