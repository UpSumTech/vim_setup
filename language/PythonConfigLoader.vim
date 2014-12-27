function language#PythonConfigLoader#Load() dict
  augroup Python
    autocmd!
    autocmd FileType python nested setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    autocmd FileType python nested setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType python nested setlocal omnifunc=pythoncomplete#Complete
  augroup END
endfunction language#PythonConfigLoader#Load

function language#PythonConfigLoader#New()
  let Retval = {
    \ 'load' : function('language#PythonConfigLoader#Load'),
  \ }
  return Retval
endfunction language#PythonConfigLoader#New
