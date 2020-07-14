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

    autocmd FileType go nnoremap <c-l>gr <Plug>(go-run)
    autocmd FileType go nnoremap <c-l>gb <Plug>(go-build)
    autocmd FileType go nnoremap <c-l>gt <Plug>(go-test)
    autocmd FileType go nnoremap <c-l>K <Plug>(go-doc)
    autocmd FileType go nnoremap <c-l>gc <Plug>(go-coverage)
    autocmd FileType go nnoremap <c-l>s <Plug>(go-def-split)
    autocmd FileType go nnoremap <c-l>v <Plug>(go-def-vertical)
    autocmd FileType go nnoremap <c-l>ec <Plug>(go-err-check)
    autocmd FileType go nnoremap <c-l>cs <Plug>(go-callstack)
    autocmd FileType go nnoremap <c-l>ife <Plug>(go-if-err)
    autocmd FileType go nnoremap <c-l>fst :GoFillStruct<CR>
    autocmd FileType go nnoremap <c-l>kfy :GoKeyify<CR>

    autocmd FileType go nnoremap <c-l>t <Plug>(go-def-type)
    autocmd FileType go nnoremap <c-l>d <Plug>(go-def)
    autocmd FileType go nnoremap <c-l>i <Plug>(go-implements)
    autocmd FileType go nnoremap <c-l>r <Plug>(go-rename)
    autocmd FileType go nnoremap <c-l>ar <Plug>(go-callers)
    autocmd FileType go nnoremap <c-l>ac <Plug>(go-callees)
    autocmd FileType go nnoremap <c-l>s :GoDecls <c-r>%<CR>

    " Please open the quickfix window to execute the following
    autocmd FileType go nnoremap <c-l>gg :VimTool go_get_project_deps<CR><CR>
    autocmd FileType go nnoremap <c-l>gT :VimTool go_test_project<CR>
  augroup END
endfunction langs#GoConfigLoader#Load

function langs#GoConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#GoConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#GoConfigLoader#New
