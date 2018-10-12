function langs#CandJavaConfigLoader#Load() dict
  augroup C_Java_Scala
    autocmd!
    autocmd FileType java,scala,c,cpp nested setlocal smartindent tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType java,scala,c,cpp nested let b:loaded_delimitMate = 1
    autocmd FileType scala            nested let g:scala_scaladoc_indent = 1
    autocmd FileType xml              nested setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType java             nested setlocal omnifunc=javacomplete#Complete
    autocmd FileType java             nested nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java             nested imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java             nested nmap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java             nested imap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java             nested nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java             nested imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java             nested nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java             nested imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
  augroup END
endfunction langs#CandJavaConfigLoader#load

function langs#CandJavaConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#CandJavaConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#CandJavaConfigLoader#New
