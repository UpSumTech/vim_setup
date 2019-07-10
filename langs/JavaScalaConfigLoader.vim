function langs#JavaScalaConfigLoader#Load() dict
  augroup Java_Scala
    autocmd!
    autocmd FileType java,scala nested let b:maplocalleader="\\"
    autocmd FileType java,scala nested let b:loaded_delimitMate = 1
    autocmd FileType scala nested let g:scala_scaladoc_indent = 1
    autocmd FileType xml nested setlocal omnifunc=xmlcomplete#CompleteTags

    autocmd FileType java nested setlocal omnifunc=javacomplete#Complete
    autocmd FileType java nested nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java nested imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java nested nmap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java nested imap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java nested nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java nested imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java nested nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java nested imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java nested nmap <localLeader>jI <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java nested nmap <localLeader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java nested nmap <localLeader>ji <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java nested nmap <localLeader>jii <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java nested imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java nested imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java nested imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
    autocmd FileType java nested imap <C-j>ii <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java nested nmap <localLeader>jM <Plug>(JavaComplete-Generate-AbstractMethods)
    autocmd FileType java nested imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)
    autocmd FileType java nested nmap <localLeader>jA <Plug>(JavaComplete-Generate-Accessors)
    autocmd FileType java nested nmap <localLeader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    autocmd FileType java nested nmap <localLeader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    autocmd FileType java nested nmap <localLeader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
    autocmd FileType java nested nmap <localLeader>jts <Plug>(JavaComplete-Generate-ToString)
    autocmd FileType java nested nmap <localLeader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
    autocmd FileType java nested nmap <localLeader>jc <Plug>(JavaComplete-Generate-Constructor)
    autocmd FileType java nested nmap <localLeader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)
    autocmd FileType java nested imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
    autocmd FileType java nested imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
    autocmd FileType java nested imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
    autocmd FileType java nested vmap <localLeader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    autocmd FileType java nested vmap <localLeader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    autocmd FileType java nested vmap <localLeader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
    autocmd FileType java nested nmap <silent> <buffer> <localLeader>jn <Plug>(JavaComplete-Generate-NewClass)
    autocmd FileType java nested nmap <silent> <buffer> <localLeader>jN <Plug>(JavaComplete-Generate-ClassInFile)

    autocmd FileType java,scala nested nnoremap <buffer> <silent> <LocalLeader>t :EnType<CR> |
    autocmd FileType java,scala nested xnoremap <buffer> <silent> <LocalLeader>t :EnType selection<CR> |
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <LocalLeader>T :EnTypeCheck<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> K  :EnDocBrowse<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> gd :EnDeclaration<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <C-]>  :EnDeclaration<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <C-w>] :EnDeclarationSplit<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <C-w><C-]> :EnDeclarationSplit<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <C-v>] :EnDeclarationSplit v<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <LocalLeader>i :EnInspectType<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <LocalLeader>I :EnSuggestImport<CR>
    autocmd FileType java,scala nested nnoremap <buffer> <silent> <LocalLeader>r :EnRename<CR>
  augroup END
endfunction langs#JavaScalaConfigLoader#load

function langs#CandJavaConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#JavaScalaConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#CandJavaConfigLoader#New
