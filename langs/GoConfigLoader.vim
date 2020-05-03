function langs#GoConfigLoader#Load() dict
  augroup Go
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 0
    let g:go_fmt_autosave = 1
    let g:go_snippet_case_type = "camelcase"
    let g:go_highlight_types = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1

    autocmd FileType go nmap <leader><S-g>r <Plug>(go-run)
    autocmd FileType go nmap <leader><S-g>b <Plug>(go-build)
    autocmd FileType go nmap <leader><S-g>t <Plug>(go-test)
    autocmd FileType go nmap <leader><S-g>d <Plug>(go-doc)
    autocmd FileType go nmap <leader><S-g>c <Plug>(go-coverage)
    autocmd FileType go nmap <leader><S-g>s <Plug>(go-def-split)
    autocmd FileType go nmap <leader><S-g>v <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader><S-g>i <Plug>(go-implements)
    autocmd FileType go nmap <leader><S-g>n <Plug>(go-rename)
    " Reminder to use C-x C-o for omni-completion

    " Please open the quickfix window to execute the following
    autocmd FileType go nmap <leader><S-g><S-g> :VimTool go_get_project_deps<CR><CR>
    autocmd FileType go nmap <leader><S-g><S-t> :VimTool go_test_project<CR>
  augroup END
endfunction langs#GoConfigLoader#Load

function langs#GoConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#GoConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#GoConfigLoader#New
