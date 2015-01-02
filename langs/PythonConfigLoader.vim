function langs#PythonConfigLoader#Load() dict
  augroup Python
    autocmd!
    autocmd FileType python nested setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    autocmd FileType python nested setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType python nested setlocal omnifunc=pythoncomplete#Complete
  augroup END
endfunction langs#PythonConfigLoader#Load

function langs#PythonConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#PythonConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#PythonConfigLoader#New
