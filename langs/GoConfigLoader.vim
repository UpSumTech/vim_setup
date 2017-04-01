function langs#GoConfigLoader#Load() dict
  augroup Go
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_autosave = 0

    autocmd!
    autocmd FileType go nmap <leader><S>gr <Plug>(go-run)
    autocmd FileType go nmap <leader><S>gb <Plug>(go-build)
    autocmd FileType go nmap <leader><S>gt <Plug>(go-test)
    autocmd FileType go nmap <leader><S>gd <Plug>(go-doc)
    autocmd FileType go nmap <leader><S>gc <Plug>(go-coverage)
    autocmd FileType go nmap <leader><S>gs <Plug>(go-def-split)
    autocmd FileType go nmap <leader><S>gv <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader><S>gi <Plug>(go-implements)
    autocmd FileType go nmap <leader><S>gn <Plug>(go-rename)
  augroup END
endfunction langs#GoConfigLoader#Load

function langs#GoConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#GoConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#GoConfigLoader#New
