function langs#GoConfigLoader#Load() dict
  augroup Go
    autocmd FileType go nmap <leader><S>gr <Plug>(go-run)
    autocmd FileType go nmap <leader><S>gb <Plug>(go-build)
    autocmd FileType go nmap <leader><S>gt <Plug>(go-test)
  augroup END
endfunction langs#GoConfigLoader#Load

function langs#GoConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#GoConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#GoConfigLoader#New
