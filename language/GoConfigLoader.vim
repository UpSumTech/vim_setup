function language#GoConfigLoader#Load() dict
  augroup Go
    autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
    autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>gr <Plug>(go-run)
    autocmd FileType go nmap <leader>gb <Plug>(go-build)
    autocmd FileType go nmap <leader>gt <Plug>(go-test)
  augroup END
endfunction language#GoConfigLoader#Load

function language#GoConfigLoader#New()
  let Retval = {
    \ 'load' : function('language#GoConfigLoader#Load'),
  \ }
  return Retval
endfunction language#GoConfigLoader#New
