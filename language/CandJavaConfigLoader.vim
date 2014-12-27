function language#CandJavaConfigLoader#Load() dict
  augroup C_Java_Scala
    autocmd!
    autocmd FileType java,scala,c,cpp nested setlocal smartindent tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType java,scala,c,cpp nested let b:loaded_delimitMate = 1
    autocmd FileType xml              nested setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END
endfunction language#CandJavaConfigLoader#load

function language#CandJavaConfigLoader#New()
  let Retval = {
    \ 'load' : function('language#CandJavaConfigLoader#Load'),
  \ }
  return Retval
endfunction language#CandJavaConfigLoader#New
