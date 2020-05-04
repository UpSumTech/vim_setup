function langs#JavaScalaConfigLoader#Load() dict
  augroup Java_Scala
    autocmd!
    autocmd FileType java,scala nested let b:maplocalleader="\\"
    autocmd FileType java,scala nested let b:loaded_delimitMate = 1
    autocmd FileType scala nested let g:scala_scaladoc_indent = 1
    autocmd FileType xml nested setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable javacomplete2 setings if the corresponding config var is set
    " By default this is disabled
    if exists('g:is_javacomplete2_plugin_enabled') && g:is_javacomplete2_plugin_enabled == 1
      autocmd FileType java nested nmap <localLeader>M <Plug>(JavaComplete-Generate-AbstractMethods)
      autocmd FileType java nested nmap <localLeader>A <Plug>(JavaComplete-Generate-Accessors)
      autocmd FileType java nested nmap <localLeader>s <Plug>(JavaComplete-Generate-AccessorSetter)
      autocmd FileType java nested nmap <localLeader>g <Plug>(JavaComplete-Generate-AccessorGetter)
      autocmd FileType java nested nmap <localLeader>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
      autocmd FileType java nested nmap <localLeader>ts <Plug>(JavaComplete-Generate-ToString)
      autocmd FileType java nested nmap <localLeader>eq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
      autocmd FileType java nested nmap <localLeader>c <Plug>(JavaComplete-Generate-Constructor)
      autocmd FileType java nested nmap <localLeader>dc <Plug>(JavaComplete-Generate-DefaultConstructor)
      autocmd FileType java nested nmap <silent> <buffer> <localLeader>n <Plug>(JavaComplete-Generate-NewClass)
      autocmd FileType java nested nmap <silent> <buffer> <localLeader>N <Plug>(JavaComplete-Generate-ClassInFile)
    endif

    " Reminder to use C-x C-o for omni-completion
  augroup END
endfunction langs#JavaScalaConfigLoader#load

function langs#JavaScalaConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#JavaScalaConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#JavaScalaConfigLoader#New
